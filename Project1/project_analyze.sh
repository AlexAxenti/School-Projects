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

#Custom Feature File Synchronization
#Called when arg1 = 4
file_sync(){

	echo "While inputting file paths, keep in mind the script executes from inside the Project1 folder"
	read -p "Enter the path of the first file: " file1
	read -p "Enter the path of the second file: " file2

	IFS=$'\n'
	smallerlength=0
	otherlength=0

	echo $file1
	echo $file2
	for i in $(cat "$file1") ; do
		smallerlength=$((smallerlength + 1))
		echo file1 "$i"
	done

	for i in $(cat "$file2") ; do
		otherlength=$((otherlength + 1))
		echo file2 "$i"
	done
	if [ $otherlength -lt $smallerlength ] ; then
		smallerlength=$otherlength
	fi
	echo $smallerlength
}

#Custom Feature Last Backup Date
#Called when arg1 = 5
last_backup(){

	if [ -f backups.log ] ; then
		rm backups.log
	fi
	touch backups.log

	response="nothing"

	#This for loop goes through files
	for i in $(find .. -name "*backup.*") ; do
		echo $(stat -c %y "$i") 'for' "$i"
		echo $(stat -c %y "$i") 'for' "$i" >> backups.log
		read -p "Would you like to create a new backup of $i? Enter 'y' or 'n': " response
		if [ $response = 'y' ] ; then
			#resourcehttps://stackoverflow.com/questions/19482123/extract-part-of-a-string-using-bash-cut-split 
			search="backup"
			extension=${i#*$search}
			extensionlength=${#extension}
			ilength=${#i}
			cutlength=$(($ilength - $extensionlength - 6))
			name=${i:0:$cutlength}$extension
			name=${name##*/}
			echo "$name"
			newfile=$(find .. -name "$name")
			echo "$newfile"
			cp -f "$newfile" "$i"
		fi
	done

	#This for loop goes through directories
	for i in $(find .. -type d -name "*backup") ; do
		echo $(stat -c %y "$i") 'for' "$i"
		echo $(stat -c %y "$i") 'for' "$i" >> backups.log
		read -p "Would you like to create a new backup of $i? Enter 'y' or 'n': " response
		if [ $response = 'y' ] ; then
			ilength=${#i}
			cutlength=$(($ilength-6))
			name=${i:0:$cutlength}
			name=${name##*/}
			newdir=$(find .. -type d -name "$name")
			echo "$i"
			echo "$newdir"
			cp -Tr "$newdir" "$i"
		fi
	done

}

#Switch to Executable feature
#Called when arg1 = 6
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
	elif [ $response = 'r' ] ; then
		if [ -f permissions.log ] ; then
			IFS=$'\n'
			for i in $(cat permissions.log) ; do
				#resource https://superuser.com/questions/1001973/bash-find-string-index-position-of-substring
				original="$i"
				index=".."
				path="${original#*$index}"
				path="$index$path"
				perms=${original:1:10}
				echo $perms
				echo $path
				perm1=0
				perm2=0
				perm3=0
				for (( j=0; j<9; j++)) ; do
					letter=${perms:$j:1}
					if [ $j -lt 3 ] ; then
						echo $j$letter
						if [ $letter = 'r' ] ; then
							perm1=$(($perm1 + 4))
						elif [ $letter = 'w' ] ; then
							perm1=$(($perm1 + 2))
						elif [ $letter = 'x' ] ; then
							perm1=$(($perm1 + 1))
						fi
					elif [ $j -lt 6 ] ; then
						echo $j$letter
						if [ $letter = 'r' ] ; then
							perm2=$(($perm2 + 4))
						elif [ $letter = 'w' ] ; then
							perm2=$(($perm2 + 2))
						elif [ $letter = 'x' ] ; then
							perm2=$(($perm2 + 1))
						fi
					else
						echo $j$letter
						if [ $letter = 'r' ] ; then
							perm3=$(($perm3 + 4))
						elif [ $letter = 'w' ] ; then
							perm3=$(($perm3 + 2))
						elif [ $letter = 'x' ] ; then
							perm3=$(($perm3 + 1))
						fi
					fi
				done
				echo $perm1$perm2$perm3
				chmod $perm1$perm2$perm3 "$path"
			done
		else
			echo "All files are already at default permissions"
		fi
	fi
}

#Backup and Delete / Restore feature
#Called when arg1 = 7
backup_restore() {

	response="nothing"

	while [ $response != 'b' ] && [ $response != 'r' ] && [ $response != 'q' ] ; do
		read -p "Would you like to backup(b) or restore(r) files? Enter exactly 'b' or 'r', or 'q' to quit the script: " response
	done

	if [ $response = 'b' ] ; then
		if [ -d backup ] ; then
			rm -r backup
		fi
		mkdir backup
		if [ ! -f ./backup/restore.log ] ; then
			touch ./backup/restore.log
		fi
		for i in $(find .. -name "*.tmp") ; do
			echo "$i" >> ./backup/restore.log
			mv "$i" ./backup
		done
	elif [ $response = 'r' ] ; then
		for i in backup/* ; do
			echo "$i"
			original="$i"
			index="backup/"
			filename="${original#*$index}"
			path="nothing"
			for j in $(grep "$filename" backup/restore.log) ; do 
				if [ "${j#*$filename}" = "" ] ; then
					path="$j"
				fi
			done
			echo "$path"
			if [ "$i" != "backup/restore.log" ] && [ -f "$i" ] ; then
				mv "$i" "$path"
			fi
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
elif [ "$1" -eq 4 ] ; then
	file_sync 
elif [ "$1" -eq 5 ] ; then
	last_backup
elif [ "$1" -eq 6 ] ; then
	switch_perms
elif [ "$1" -eq 7 ] ; then
	backup_restore
fi

