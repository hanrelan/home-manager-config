#!/bin/bash

case $1 in
	get)
		BRIGHTNESS1=`ddcutil getvcp 10 --display 1 | awk '{print $9}' | sed 's/,//'`
		BRIGHTNESS2=`ddcutil getvcp 10 --display 2 | awk '{print $9}' | sed 's/,//'`

		echo "$BRIGHTNESS1 / $BRIGHTNESS2"
	;;

	increase)
		ddcutil setvcp 10 + 10 --display 1
		ddcutil setvcp 10 + 10 --display 2
	;;

	decrease)
		ddcutil setvcp 10 - 10 --display 1
		ddcutil setvcp 10 - 10 --display 2
	;;
esac
