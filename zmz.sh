#!/bin/bash

OPC=`zenity --list --radiolist --column=OPCION --column=ACCION --hide-header $( echo -e "1 Lista\n2 Simple\n3 Leer\n4 Borrar" )`

case $OPC in
Lista)
	A1=`gammu getallmemory SM 2>/dev/null | grep -e 'general' -e 'Nombre'`
	A2=`gammu getallmemory ME 2>/dev/null | grep -e 'general' -e 'Nombre'`
	zenity --info --ellipsize --text="$A1\n$A2"
;;

Simple)
	A=`zenity --forms --add-entry=Numero --add-entry=Texto --text=SMS`
	A1=`echo $A | cut -d '|' -f 1`
	A2=`echo $A | cut -d '|' -f 2`

	zenity --question --default-cancel --text=$A1

	if [ $? -eq 0 ] ;  then
		S=`echo $A2 | gammu sendsms TEXT $A1`
		zenity --info --text="$S"
	else
		echo "no"
	fi
;;

Leer)
	A=`gammu getallsms`
	zenity --info --ellipsize --text=`echo "$A"`
	echo "$A"
;;

Borrar)
	zenity --question --default-cancel --text="¿Seguro?"

	if [ $? -eq 0 ] ;  then
		gammu getsmsfolders
		gammu deleteallsms 1
		gammu deleteallsms 2
		gammu deleteallsms 3
		gammu deleteallsms 4
	else
		echo "no"
	fi
;;

esac