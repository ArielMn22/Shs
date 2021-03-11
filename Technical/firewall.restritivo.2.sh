#!/bin/bash

# DECLARAR POLITICA PADRAO COMO RESTRITIVA
	iptables -P INPUT DROP
	iptables -P OUTPUT DROP
	iptables -P FORWARD DROP

# LIMPAR AS REGRAS DAS CHAINS
	iptables -F

# LIBERAR A INTERFACE LOOPBACK

# regra baseada em ip
	#iptables -A INPUT -s 127.0.0.1 -j ACCEPT
	#iptables -A OUTPUT -d 127.0.0.1 -j ACCEPT

# regra baseada em interface
	iptables -A INPUT -i lo -j ACCEPT
	iptables -A OUTPUT -o lo -j ACCEPT

# LIBERAR O ACESSO SSH DO FIREWALL
	#iptables -A INPUT -p tcp --dport 2222 -j ACCEPT
	#iptables -A OUTPUT -p tcp --sport 2222 -j ACCEPT

# LIBERAR O ICMP PARA TODO CENARIO
	#iptables -A INPUT -p icmp -j ACCEPT
	#iptables -A OUTPUT -p icmp -j ACCEPT
	#iptables -A FORWARD -p icmp -j ACCEPT

# RESTRINGIR SSH DO SRVFW-BERLIM PARA CLIENTE, SERVIDORES E INTERNET
	iptables -A INPUT -p tcp -i eth0 --dport 2222 -j ACCEPT
	iptables -A INPUT -p tcp -i eth1 --dport 2222 -j ACCEPT
	iptables -A INPUT -p tcp -i eth2 --dport 2222 -j ACCEPT
	iptables -A OUTPUT -p tcp -o eth0 --sport 2222 -j ACCEPT
	iptables -A OUTPUT -p tcp -o eth1 --sport 2222 -j ACCEPT
	iptables -A OUTPUT -p tcp -o eth2 --sport 2222 -j ACCEPT

# LIBERAR PROTOCOLO DNS
	# region WRONG APPROACH
	# iptables -A INPUT -p udp --dport 53 -j ACCEPT
	# iptables -A OUTPUT -p udp --sport 53 -j ACCEPT
	# endregion
	iptables -A FORWARD -p udp --dport 53 -j ACCEPT
	iptables -A FORWARD -p udp --sport 53 -j ACCEPT
	iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
	iptables -A INPUT -p udp --sport 53 -j ACCEPT

# LIBERAR REPOSITÓRIO LINUX (APT UPDATE)
	iptables -A FORWARD -d ftp.debian.org -j ACCEPT
	iptables -A FORWARD -s ftp.debian.org -j ACCEPT
	iptables -A OUTPUT -d ftp.debian.org -j ACCEPT
	iptables -A INPUT -s ftp.debian.org -j ACCEPT

# LIBERAR PROTOCOLO FTP
	iptables -A INPUT -p tcp --match multiport --dport 20,21 -j ACCEPT	
	iptables -A INPUT -p tcp --match multiport --dport 20,21 -j ACCEPT	
	iptables -A OUTPUT -p tcp --match multiport --dport 20,21 -j ACCEPT	
	iptables -A OUTPUT -p tcp --match multiport --sport 20,21 -j ACCEPT	
	iptables -A FORWARD -p tcp --match multiport --dport 20,21 -j ACCEPT	
	iptables -A FORWARD -p tcp --match multiport --sport 20,21 -j ACCEPT	

# Dropar "ICMP" do SRVWEB-DENVER para CLIENTE, quando for acionado gere log dizendo "Acesso ao Cliente bloqueado"
	iptables -A FORWARD -p icmp -s 172.31.100.252 -d 10.10.100.1 --log-prefix "Acesso ao Cliente bloqueado" -j DROP

# LIBERAR COMPARTILHAMENTO DE ARQUIVOS DO SRVDV-NAIROBI SOMENTE PARA O CLIENTE
	iptables -A FORWARD -p tcp -s 172.31.100.252 --match multiport --dport 20,21 -j DROP
	iptables -A FORWARD -p tcp -s 172.31.100.252 -d 10.10.100.1 --match multiport --dport 20,21 -j ACCEPT

clear
iptables -L -nv --line-numbers
