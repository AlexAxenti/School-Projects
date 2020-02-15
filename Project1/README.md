# CS 1XA3 Project01 - axentia

## Usage
To execute this script, the script must be kept in its 'Project1' folder, as well as the 'Project1' folder to be 
placed in the root of the repo. Then, the script can be executed with the following commands while in the 
'Project1' directory:

	chmod +x project_analyze.sh

	./project_analyze arg1

There is only one required argument with possible inputs 1, 2, or 3.
List of inputs with corresponding feature:

	1 - FIXME Log
	
	2 - File Type Count
	
	3 - Find Tag

## Feature FIXME Log
Description: This feature will find every file in your repo that contains the word '#FIXME' in its last line.
These files will then be recorded into a new file (or overwritting the existing file) named fixme.log.

Execution: To execute this file, arg1 when calling the script must be '1' as such:

	./CS1XA3/Project01/project_analyze 1

Reference:
How to find the last line of a file: https://kb.iu.edu/d/acrj 

## Feature File Type Count
Description: The user is prompted for a file extension (txt, pdf, etc). The script will then output how many files 
of that type exist in your repo

Exectuion: To execute this file, agr1 when calling the script must be '2' as such:

	./CS1XA3/Project01/project_analyze 2

As well as inputting a correct file type extension when prompted by the script.

## Feature File Tag
Description: The user is prompted for a specific word or 'tag'. The script then searches for every py file that has a
comment which includes the tag on that line The file along with the line is then recorded into a file tag.log
(named after the inputted tag).

Execution: To execute this file, agr1 when calling the script must by '3' as such:

	./CS1XA3/Project01/project_analyze 3

As well as inputting one word when prompted by the script

Reference: https://www.computerhope.com/unix/uegrep.htm for how to use egrep and properly format the 'pattern' when 
searching for the tag.

## Custom Feature File Synchonization
Description: This script will compare two files (the user will be prompted for the two file paths) line by line 
and upon discovering a line that is different between the two files, the user will be asked which line they would
like to keep. After going through each of the lines, a new file will be created composed of all the identical lines,
as well as the lines that the user specified to keep. There will also be a log created that keeps track of which
lines were kept or not kept.

Execution: To execute this file, agr1 when calling the script must be '4' as such:

	./CS1XA3/Project01/project_analyze 4

The user will also be prompted for two file paths, and upon discovering unidentical lines, the user will be prompted
for which line they would like to keep, by inputting '1' or '2'.

##Custom Feature Something
