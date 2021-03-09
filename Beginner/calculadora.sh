#!/bin/bash
# CALCULADORA_SIMPLES
# Um de meus primeiros scripr em shell script
# By ArielMn22 (arielpaixao10@gmail.com)

clear 						#Limpa a tela

DESEJAC=sim 					#Estabelece o conteúdo da variável  

function pergunta() 				#Início da função
{
	echo 'Deseja continuar?' 		#Imprime na tela 
	read DESEJAC 				#Grava a variável
}

while [ $DESEJAC == sim ] 			#Início da while
do
	echo 'Digite um cálculo:' 		#Imprima na tela
	read CALCULO 				#Grava a variável
	clear 					#Limpa a tela
	RESULTADO=$(($CALCULO)) 		#Realiza o cálculo e grava na variável
	echo 'O resultado é:' 			#Imprime na tela
	echo $RESULTADO 			#Imprime na tela
	pergunta 				#Chama a função
done 						#Fim da while
