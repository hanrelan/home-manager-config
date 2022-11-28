#!/bin/bash
result=""
for gpu in 0 1
do
	used=`nvidia-smi -i $gpu --query-gpu=utilization.gpu --format=csv,noheader | cut -b 1-2 | cut -b 1-2 | tr -d '.'`
	if [ "$used" -lt 11 ]
	then
		# result+="🮀"
		result+="▁"
	elif [ $used -lt 22 ]
	then
		result+="▁"
	elif [ $used -lt 33 ] 
	then
		result+="▂"
	elif [ $used -lt 44 ]
	then
		result+="▃"
	elif [ $used -lt 55 ]
	then
		result+="▄"
	elif [ $used -lt 66 ]
	then
		result+="▅"
	elif [ $used -lt 77 ]
	then
		result+="▆"
	elif [ $used -lt 88 ]
	then
		result+="▇"
	else
		#echo "█"
		result+="%{F#f00} ▇ %{F-}"
	fi
	result+=" "
done

echo $result | xargs

