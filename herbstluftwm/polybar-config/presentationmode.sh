#!/bin/bash

trim() {
    local var="$*"
    # remove leading whitespace characters
    var="${var#"${var%%[![:space:]]*}"}"
    # remove trailing whitespace characters
    var="${var%"${var##*[![:space:]]}"}"
    printf '%s' "$var"
}

UPDATE="polybar-msg hook presentationmode 1"

case $1 in
	get)
		PRESENTATIONMODE=`xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -v`
		if [ $PRESENTATIONMODE = "true" ]
		then
			echo "  on"
		else
			echo "  off"
		fi
	;;

	toggle)
		xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -T
		# ddcutil setvcp 10 + 10 --display 2
		eval "$UPDATE"
	;;
esac
