#!/bin/bash

# FIXME Log function
# Called when arg1 = 1
fixme_log() {
	if [ -f fixme.log ] ; then
		rm fixme.log
	fi

	touch fixme.log
	IFS=$'\n'
	for i in $(find .. -type f -name "*.*") ; do
		for j in $(tail -n 1 "$i") ; do
			if [ "$j" = "#FIXME" ] ; then
				echo "$i" >> fixme.log
			fi
		done
	done

}


#File Type Count function
#Called when arg1 = 2
file_count() {

	counter=0
	read -p "Enter a file type: " filetype
	IFS=$'\n'
	for i in $(find .. -name "*.$filetype") ; do
		counter=$(($counter + 1))
	done
	echo $counter

}

#Find Tag feature
#Called when arg1 = 3
find_tag() {

	read -p "Enter a single word to search for: " tag

	if [ -f "$tag.log" ] ; then
		rm "$tag.log"
	fi
	touch "$tag.log"
	IFS=$'\n'
	for i in $(find .. -name "*.py") ; do
		for j in $(egrep "^#.*$tag.*" "$i") ; do
			echo "$i" "$j" >> "$tag.log" 
		done
	done

}

switch_perms() {

	response="nothing"

	while [ $response != 'c' ] && [ $response != 'r' ] && [ $response != 'q' ] ; do
		read -p "Would you like to change(c) or restore(r) file permissions? Must enter exactly 'c' or 'r' or enter 'q' to quit : " response
	done

	if [ $response = 'q' ] ; then
		echo "Exiting script"
	elif [ $response = 'c' ] ; then
		if [ -f permissions.log ] ; then
			rm permissions.log
		fi
		touch permissions.log

		IFS=$'\n'
		for i in $(find .. -name "*.sh") ; do
			counter=0
			echo $(ls -l "$i") >> permissions.log
			#resource https://stackoverflow.com/questions/10551981/how-to-perform-a-for-loop-on-each-character-in-a-string-in-bash
			perm=$(echo $(ls -l "$i"))
			for (( j=0; j<10; j++ )) ; do
				counter=$(($counter + 1))
				letter=${perm:$counter:1}
				echo $letter
				if [ $counter -eq 1 ] ; then
					if [ $letter = "r" ] ; then
						chmod u+x "$i"
					fi
				elif [ $counter -eq 4 ] ; then
					if [ $letter = "r" ] ; then
						chmod g+x "$i"
					fi
				elif [ $counter -eq 7 ] ; then
					if [ $letter = "r" ] ; then
						chmod o+x "$i"
					fi
				fi
			done
		done
	fi
}

#Script Input
#Args 1-3 call a specified function
if [ "$1" -eq 1 ] ; then
	fixme_log
elif [ "$1" -eq 2 ] ; then
	file_count
elif [ "$1" -eq 3 ] ; then
	find_tag
elif [ "$1" -eq 6 ] ; then
	switch_perms
fi

