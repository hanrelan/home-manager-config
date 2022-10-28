#!/bin/bash

trim() {
    local var="$*"
    # remove leading whitespace characters
    var="${var#"${var%%[![:space:]]*}"}"
    # remove trailing whitespace characters
    var="${var%"${var##*[![:space:]]}"}"
    printf '%s' "$var"
}

UPDATE="polybar-msg hook brightnesscontrol 1"

case $1 in
	get)
		BRIGHTNESS1=`ddcutil getvcp 10 --display 1 | awk '{print $9}' | sed 's/,//'`
		BRIGHTNESS2=`ddcutil getvcp 10 --display 2 | awk '{print $9}' | sed 's/,//'`

		echo "$BRIGHTNESS1 / $BRIGHTNESS2"
	;;

	increase)
		ddcutil setvcp 10 + 10 --display 1
		ddcutil setvcp 10 + 10 --display 2
		eval "$UPDATE"
	;;

	decrease)
		ddcutil setvcp 10 - 10 --display 1
		ddcutil setvcp 10 - 10 --display 2
		eval "$UPDATE"
	;;
	set)
		result=$(echo "" | rofi -no-config -no-lazy-grab -theme ~/.config/polybar/cuts/scripts/rofi/message.rasi -dmenu -p "New brightness: ")
		if [[ $result == *"/"* ]]; then
			# format is 50 / 50
			 IFS='/'

			read -a strarr <<< "$result"
			b1=$(echo ${strarr[0]} | xargs)
			b2=$(echo ${strarr[1]} | xargs)
			ddcutil setvcp 10 $b1 --display 1
			ddcutil setvcp 10 $b2 --display 2
		else
			ddcutil setvcp 10 $result --display 1
			ddcutil setvcp 10 $result --display 2
		fi
		eval "$UPDATE"
	;;
esac
