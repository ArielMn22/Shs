#!/bin/bash

COMANDS=("wget http://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb -O libpng12_ubuntu17.10.deb" \
"sudo dpkg -i libpng12_ubuntu17.10.deb" \
"wget http://kdl1.cache.wps.com/ksodl/download/linux/a21//wps-office_10.1.0.5707~a21_amd64.deb -O wps-office.deb" \
"wget http://kdl.cc.ksosoft.com/wps-community/download/fonts/wps-office-fonts_1.0_all.deb -O web-office-fonts.deb" \
"sudo dpkg -i wps-office.deb" \
"sudo dpkg -i web-office-fonts.deb")

clear

noparameters(){
  for x in {0..5}; do
   echo "${COMANDS[$x]} #COMANDO=$x" # Exibe o comando a ser executado.
   ${COMANDS[$x]} &>/dev/null || echo "Erro no comando '$x'" # Executa o comando guardado na posição $x do array.
   echo "###################################################" # Linha delimitadora do comando.
  done
} # Executa os comandos sem mostrar a saída dos mesmos.

vparameter(){
  for x in {0..5}; do
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

rm -rf libpng12_ubuntu17.10.deb wps-office.deb web web-office-fonts.deb
