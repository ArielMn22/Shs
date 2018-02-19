#!/bin/bash

COMANDS=("dpkg --add-architecture i386" "wget -nc https://dl.winehq.org/wine-builds/Release.key" "apt-key add Release.key" "apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/ -y" "apt-get update" \
"apt-get install --install-recommends winehq-stable -y" "apt-get install -f")

clear

noparameters(){
  for x in {0..6}; do
   echo "${COMANDS[$x]} #COMANDO=$x" # Exibe o comando a ser executado.
   ${COMANDS[$x]} &>/dev/null || echo "Erro no comando '$x'" # Executa o comando guardado na posição $x do array.
   echo "###################################################" # Linha delimitadora do comando.
  done
} # Executa os comandos sem mostrar a saída dos mesmos.

vparameter(){
  for x in {0..6}; do
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
