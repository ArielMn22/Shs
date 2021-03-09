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
iptables -A INPUT -p tcp -d 172.31.100.254 --dport 2222 -j ACCEPT
iptables -A OUTPUT -p tcp -j ACCEPT

# LIBERAR O ICMP PARA TODO CENARIO
iptables -A INPUT -p icmp -j ACCEPT
iptables -A OUTPUT -p icmp -j ACCEPT
iptables -A FORWARD -p icmp -j ACCEPT

clear
iptables -L -nv --line-numbers
