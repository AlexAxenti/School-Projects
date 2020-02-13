# CS 1XA3 Project01 - axentia

## Usage
Execute this script from the project root with:

	chmod +x CS1XA3/Project01/project_analyze.sh

	./CS1XA3/Project1/project_analyze arg1

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
