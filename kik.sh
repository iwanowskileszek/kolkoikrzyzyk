#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NONE='\033[0m'

WYGRANA="0"
GRACZ="1"
PLANSZA=("0" "0" "0" "0" "0" "0" "0" "0" "0")

function wyswietl {
	clear
	echo -e "${RED}Plansza"
	echo "${PLANSZA[0]} | ${PLANSZA[1]} | ${PLANSZA[2]}"
	echo "${PLANSZA[3]} | ${PLANSZA[4]} | ${PLANSZA[5]}"
	echo "${PLANSZA[6]} | ${PLANSZA[7]} | ${PLANSZA[8]}"
}

function sprawdzWygrana {
	for POLE in {0..2}
	do
		#rows
		ROW=POLE*3
		if [ ${PLANSZA[$ROW]} -eq $GRACZ ] && [ ${PLANSZA[$[$ROW+1]]} -eq $GRACZ ] && [ ${PLANSZA[$[$ROW+2]]} -eq $GRACZ ]
		then
			WYGRANA="1"
		fi
		#columns:
		if [ ${PLANSZA[$POLE]} -eq $GRACZ ] && [ ${PLANSZA[$[$POLE+3]]} -eq $GRACZ ] && [ ${PLANSZA[$[$POLE+6]]} -eq $GRACZ ]
		then
			WYGRANA="1"
		fi
	done
	
	if [ ${PLANSZA[0]} -eq $GRACZ ] && [ ${PLANSZA[4]} -eq $GRACZ ] && [ ${PLANSZA[8]} -eq $GRACZ ];then WYGRANA="1";fi
        if [ ${PLANSZA[2]} -eq $GRACZ ] && [ ${PLANSZA[4]} -eq $GRACZ ] && [ ${PLANSZA[6]} -eq $GRACZ ];then WYGRANA="1";fi
}


while true
do
	while true
	do
		
		while true
		do
			echo -e "${NONE}"
			wyswietl
			case $GRACZ in
				"1") echo -e "${GREEN}" ;;
				"2") echo -e "${BLUE}" ;;
			esac
			echo
			echo "Gracz nr = ${GRACZ}"
			read -n 1 -p "Podaj nr wiersza [1,2,3] " XXX
			echo
			read -n 1 -p "podaj nr kolumny [1,2,3] " YYY
			echo -e "${NONE}"
			if [ $XXX -gt "0" ] && [ $XXX -lt "4" ] && [ $YYY -gt "0" ] && [ $YYY -lt "4" ]; then break;else echo -ne '\007'; fi
		done	
		if [ ${PLANSZA[$[(XXX-1)*3+(YYY-1)]]} -eq "0" ];then
			PLANSZA[(XXX-1)*3+(YYY-1)]=$GRACZ
			break
		else
			echo -ne '\007'
			echo -e "\n===================================================="
			echo "POLE ${XXX-1}, ${YYY-1} JEST ZAJĘTE"
			echo -e "MUSISZ PODAC INNE WSPÓŁRZĘDNE\n"
			read -s -n 1 -p "Naciśnij jakikolwiek klawisza aby kontynuować"
		fi 
	done
	sprawdzWygrana
	wyswietl
	if [ $WYGRANA -eq "1" ];then
		case $GRACZ in 
        		"1") echo -e "${GREEN}" ;;
			"2") echo -e "${BLUE}" ;;
		esac
		echo -e "\n=====================================================\n"
		echo "                Wygral gracz ${GRACZ}"
		echo -e "\n=====================================================${NONE}"
		read -n 1 -p "KONIEC [t/n] " KONIEC
		if [ $KONIEC == "t" ] || [ $KONIEC == "T" ]; then
			clear;
			unset GREEN
			unset BLUE
			unset NONE
			unset WYGRANA
			unset GRACZ
			unset PLANSZA
			unset KONIEC
			break;
		fi
		WYGRANA="0"
		GRACZ="1"
		echo -e "${GREEN}"
	fi
	case $GRACZ in
		"1") GRACZ="2";echo -e "${BLUE}" ;;
		"2") GRACZ="1";echo -e "${GREEN}" ;;
	esac

done

 
