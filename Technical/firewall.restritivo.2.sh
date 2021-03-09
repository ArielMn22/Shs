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
	iptables -A INPUT -p icmp -j ACCEPT
	iptables -A OUTPUT -p icmp -j ACCEPT
	iptables -A FORWARD -p icmp -j ACCEPT

# RESTRINGIR SSH DO SRVFW-BERLIM PARA CLIENTE, SERVIDORES E INTERNET
	iptables -A INPUT -p tcp -i eth0 --dport 2222 -j ACCEPT
	iptables -A INPUT -p tcp -i eth1 --dport 2222 -j ACCEPT
	iptables -A INPUT -p tcp -i eth2 --dport 2222 -j ACCEPT
	iptables -A OUTPUT -p tcp -o eth0 --sport 2222 -j ACCEPT
	iptables -A OUTPUT -p tcp -o eth1 --sport 2222 -j ACCEPT
	iptables -A OUTPUT -p tcp -o eth2 --sport 2222 -j ACCEPT

# LIBERAR PROTOCOLO DNS
	iptables -A INPUT -p udp --dport 53 -j ACCEPT
	iptables -A OUTPUT -p udp --sport 53 -j ACCEPT

# LIBERAR REPOSITÓRIO LINUX (APT UPDATE)
	#TODO - Allow http, ftp and udp
clear
iptables -L -nv --line-numbers
