#!/bin/bash

# FIXME Log function
# Called when arg1 = 1
fixme_log() {
	if [ -f fixme.log ] ; then
		rm fixme.log
	fi

	touch fixme.log

	for i in $(find . -name "*.txt") ; do
		for j in $(tail -n 1 "$i") ; do
			if [ "$j" = "#FIXME" ] ; then
				echo "$i" >> fixme.log
			fi
		done
	done


}

#File Type Count function
#Called when arg2 = 2
file_count() {
	counter=0
	read -p "Enter a file type: " filetype
	for i in $(find . -name "*.$filetype") ; do
		counter=$(($counter + 1))
	done
	echo $counter

}


#Script Input
#Args 1-4 call a specified function
if [ "$1" -eq 1 ] ; then
	fixme_log
elif [ "$1" -eq 2 ] ; then
	file_count
fi


