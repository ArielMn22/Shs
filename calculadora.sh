#!/bin/bash

clear

DESEJAC=sim

function pergunta()
{
	echo 'Deseja continuar?'
	read DESEJAC
}
while [ $DESEJAC == sim ]
do
	echo 'Digite um cálculo:'
	read CALCULO
	clear
	RESULTADO=$(($CALCULO))
	echo 'O resultado é:'
	echo $RESULTADO
	pergunta
done
