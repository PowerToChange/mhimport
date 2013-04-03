#!/bin/bash
# This file is a batch script to create the appDev documentation locally.
# Documentation is created from code comments

FILE_PATH=$1

EXCLUDED_DIR=`cat docbuildexcl.txt`
EXCLUDED_DIRS=${EXCLUDED_DIR//\//\\/}
#echo "$EXCLUDED_DIRS"

#directory path
DIR_PATH=`dirname $FILE_PATH`/

#directory name alone
DIR_PATH_BASENAME=`basename $DIR_PATH`

#file name alone
FILE_PATH_BASENAME=`basename $FILE_PATH`

#echo -n $FILE_PATH

#DIR_PATH_REG=${DIR_PATH//\//\\/}
#DIR_PATH_REGEX=${DIR_PATH_REG//\./}

#echo $DIR_PATH_REGEX

#echo $TESTDONE

#COUNTER=0
while read -r FINDLINE ; 
do
	#COUNTER=$(expr $COUNTER+1)
	#test if excluded path
	#echo $COUNTER" testing if "$FINDLINE" in "$FILE_PATH

	#TESTDONE=`grep --regex="$FINDLINE" "$DIR_PATH"`
	#if [[ "${DIR_PATH}" == *${FINDLINE}* ]];
	#if [ $"TESTDONE" != "" ];

	if [[ "$DIR_PATH" == *$FINDLINE* ]];
	then
		exit
	fi

done <<< "$EXCLUDED_DIRS"

#echo ..found
echo processing..$FILE_PATH

DOCSFILE=`cat docs.js`

DEPTHCOUNT=$((`echo $FILE_PATH|sed 's/[^\\/]//g'|wc -m`-1))

NEWPATH="_."$FILE_PATH_BASENAME
NEWDIRPATH="._"$DIR_PATH_BASENAME
for (( c=1; c<=$DEPTHCOUNT; c++ ))
do
	NEWPATH="__"$NEWPATH

	if [ $c != 1 ];
	then
		NEWDIRPATH="__"$NEWDIRPATH
	fi
done

#echo "checking for.."$NEWPATH
NEWPATH_REG=${NEWPATH//\./\\.}

if [[ "$DOCSFILE" == *$NEWPATH_REG* ]];
	then
		exit
	fi

echo "creating new documentation for "$NEWPATH
echo "//required to separate comment blocks for documentjs, please do not remove" >> doc_build.txt
echo "var __filler;" >> doc_build.txt
echo "/**" >> doc_build.txt
echo " * @filename "$NEWPATH >> doc_build.txt
echo " * @parent "$NEWDIRPATH >> doc_build.txt
echo " * " >> doc_build.txt
echo " * This file <does something>" >> doc_build.txt
echo " * " >> doc_build.txt
echo " */" >> doc_build.txt
echo " " >> doc_build.txt


