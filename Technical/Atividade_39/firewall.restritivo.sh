#!/bin/bash

MESSAGE=""

# HELPERS
awaitInput() {

	read -p "${MESSAGE}"

}

clear

# A) POLÍTICA RESTRITIVA
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP
MESSAGE="Política restritiva executada - OK!"
awaitInput

# LIMPAR CHAINS DE EXCEÇÃO
iptables -F
MESSAGE="Chains limpas - OK!"
awaitInput

# B) LIBERAR ICMP
iptables -A INPUT -p icmp -j ACCEPT
iptables -A OUTPUT -p icmp -j ACCEPT
iptables -A FORWARD -p icmp -j ACCEPT
MESSAGE="ICMP Liberado - OK!"
awaitInput

# C) LIBERAR REPOSITÓRIO BRASILEIRO DO DEBIAN (LINUX)

#region - liberar ftp
iptables -A INPUT -p tcp --match multiport --dport 20,21 -j ACCEPT
iptables -A INPUT -p tcp --match multiport --sport 20,21 -j ACCEPT
iptables -A OUTPUT -p tcp --match multiport --dport 20,21 -j ACCEPT
iptables -A OUTPUT -p tcp --match multiport --sport 20,21 -j ACCEPT
iptables -A FORWARD -p tcp --match multiport --dport 20,21 -j ACCEPT
iptables -A FORWARD -p tcp --match multiport --sport 20,21 -j ACCEPT
#endregion - liberar ftp

#region - liberar dns
iptables -A FORWARD -p udp --dport 53 -j ACCEPT
iptables -A FORWARD -p udp --sport 53 -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p udp --sport 53 -j ACCEPT
#endregion - liberar dns

iptables -A FORWARD -d ftp.br.debian.org -j ACCEPT
iptables -A FORWARD -s ftp.br.debian.org -j ACCEPT
iptables -A OUTPUT -d ftp.br.debian.org -j ACCEPT
iptables -A INPUT -s ftp.br.debian.org -j ACCEPT
MESSAGE="Repositório liberado - OK!"
awaitInput

# D) REJEITAR "ICMP" DO CLIENTE PARA SRVFW-BERLIM, GERANDO LOG QUANDO ACIONADO
iptables -A INPUT -p icmp -s 10.10.100.1 -j LOG --log-prefix "ICMP do Cliente para SRVFW-BERLIM bloqueado"
iptables -A INPUT -p icmp -s 10.10.100.1 -j REJECT
MESSAGE="ICMP do cliente para srvfw-berlim bloqueado - OK!"
awaitInput

# E) LIBERAR ACESSO A INTERNET (NAVEGAÇÃO); EXCETO SRVWEB-DENVER
iptables -A FORWARD -p tcp -s 172.31.100.253 --match multiport --dport 80,443 -j DROP
iptables -A FORWARD -p tcp -d 172.31.100.253 --match multiport --dport 80,443 -j DROP
iptables -A FORWARD -p tcp --match multiport --dport 80,443 -j ACCEPT
MESSAGE="Liberar navegação para todos dispositivos exceto SRVWEB-DENVER - OK!"
awaitInput

echo ""
echo "======================"
echo "IPTABLES Configuration"
echo "======================"
iptables -nvL
