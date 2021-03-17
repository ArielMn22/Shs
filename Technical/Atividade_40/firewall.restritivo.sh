#!/bin/bash

MESSAGE=""

# HELPERS
awaitInput() {

	read -p "${MESSAGE}"

}

clear

echo "====================="
echo "IPTABLES CONFIGURATOR"
echo "====================="
echo -e "Aperte [ENTER] para executar cada etapa passo-a-passo\n"
read -p ""

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

# ALO
iptables -t nat -A PREROUTING -p tcp -d 172.31.100.253 --dport 22 -j REDIRECT --to-ports 2223

echo ""
echo "======================"
echo "IPTABLES Configuration"
echo "======================"
iptables -nvL
