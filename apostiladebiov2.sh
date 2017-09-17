#!/bin/bash
clear
echo 'Digite um número: '
read NUM
echo 'Digite a idade:'
read ANOS
clear
if [ $ANOS = 50 ]
then
	VALOR=109228
else
	if [ $ANOS = 60 ]
	then
		VALOR=145279
	else
		if [ $ANOS = 70 ]
		then
			VALOR=182167
		else
			if [ $ANOS = 80 ]
			then
				VALOR=184563
			else
				echo 'Idade inválida'
			fi
		fi
	fi
fi

echo 'Seu resultado é:'
echo $(($NUM*100/$VALOR))
