#!/bin/bash

COMANDS=("sudo sh -c echo deb http://deb.opera.com/opera-stable/ stable non-free >> /etc/apt/sources.list.d/opera.list" \
"wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -" \
"sudo apt-get update" \
"sudo apt-get install opera-stable")

clear

noparameters(){
  for x in {0..3}; do
   echo "${COMANDS[$x]} #COMANDO=$x" # Exibe o comando a ser executado.
   ${COMANDS[$x]} &>/dev/null || echo "Erro no comando '$x'" # Executa o comando guardado na posição $x do array.
   echo "###################################################" # Linha delimitadora do comando.
  done
} # Executa os comandos sem mostrar a saída dos mesmos.

vparameter(){
  for x in {0..3}; do
   echo "${COMANDS[$x]} #COMANDO=$x" # Exibe o comando a ser executado.
   ${COMANDS[$x]} || echo "Erro no comando '$x'" # Executa o comando guardado na posição $x do array.
   echo "###################################################" # Linha delimitadora do comando.
  done
} # Executa os comandos mostrando a saída deles.

if [[ $1 == "-v" ]]
then
  vparameter
else
  noparameters
fi

rm -rf Release.key
