#!/bin/bash

# DECLARAR A POLITICA PADRAO COMO PERMISSIVA
iptables -t filter -P INPUT ACCEPT
iptables -t filter -P OUTPUT ACCEPT
iptables -t filter -P FORWARD ACCEPT

# LIMPAR AS REGRAS DE EXCECAO CONTIDAS NAS CHAINS
iptables -F

# LIMPAR A CONSOLE E MOSTRAR A CONFIGURACAO ATUAL
clear
iptables -L
