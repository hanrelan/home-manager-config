#!/bin/bash

hlwm_config=~/.config/herbstluftwm
if [ -L ${hlwm_config} ] && [ -e ${hlwm_config} ] ; then
	echo "HLWM config already symlinked"
else
	rm -rf ${hlwm_config}
	ln -s ${PWD}/config ${hlwm_config} && echo "Symlink created for HLWM config"
fi


polybar_config=~/.config/polybar
if [ -L ${polybar_config} ] && [ -e ${polybar_config} ] ; then
	echo "Polybar config already symlinked"
else
	rm -rf ${polybar_config}
	ln -s ${PWD}/polybar-config ${polybar_config} && echo "Symlink created for polybar config"
fi

echo "restarting hlwm"

bash ${hlwm_config}/autostart
