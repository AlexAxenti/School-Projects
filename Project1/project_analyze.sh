#!/bin/bash

# FIXME Log function
# Called when arg1 = 1
fixme_log() {
	if [ ! -f fixme.log ] ; then
		touch fixme.log
	else
		rm fixme.log
		touch fixme.log
	fi

	for i in $(find . -name "*.txt") ; do
		for j in $(tail -n 1 "$i") ; do
			if [ "$j" = "#FIXME" ] ; then
				echo "$i" >> fixme.log
			fi
		done
	done


}

if [ "$1" -eq 1 ] ; then
	fixme_log
fi

