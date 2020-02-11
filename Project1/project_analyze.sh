#!/bin/bash

# FIXME Log function
# Called when arg1 = 1
fixme_log() {
	if [ ! -f fixme.log ] ; then
		touch fixme.log
	fi

	for i in $(find . -name "*.txt") ; do
		echo "$i"
	done


}

if [ "$1" -eq 1 ] ; then
	fixme_log
fi

