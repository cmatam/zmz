#!/bin/bash

OPC=`zenity --list --radiolist --column=OPCION --column=ACCION --hide-header $( echo -e "1 Lista\n2 Simple\n3 Leer\n4 Borrar" )`

case $OPC in
Lista)

	LIS=`gammu getallmemory ME 2>/dev/null | grep -e 'general' -e 'Nombre' | cut -d ':' -f 2`
	A1=`zenity --list --column=COLUMNA $LIS`
	A2=`zenity --text-info --editable`

	zenity --question --default-cancel --text=`echo -e "$A2\n$A1"`

	if [ $? -eq 0 ] ;  then
		S=`echo $A2 | gammu sendsms TEXT $A1`
		zenity  --info --text=$S
	else
		echo "no"
	fi
;;

Simple)
	A=`zenity --forms --add-entry=Numero --add-entry=Texto --text=SMS`
	A1=`echo $A | cut -d '|' -f 1`
	A2=`echo $A | cut -d '|' -f 2`

	zenity --question --default-cancel --text=$A1

	if [ $? -eq 0 ] ;  then
		S=`echo $A2 | gammu sendsms TEXT $A1`
		zenity  --info --text=$S
	else
		echo "no"
	fi
;;

esac