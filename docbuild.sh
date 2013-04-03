#!/bin/bash
# This file is a batch script to create the appDev documentation locally.
# Documentation is created from code comments

echo > doc_build.txt

TARGET_FILE=$0

cd `dirname $TARGET_FILE`
TARGET_FILE=`basename $TARGET_FILE`
echo "	script file.."$TARGET_FILE

PHYS_DIR=`pwd -P`
SCRIPT=$PHYS_DIR/$TARGET_FILE

# Absolute path this script is in.
BASE=`dirname $SCRIPT`/
echo "	path of script file.."$BASE

# parent directory
PARENT=`basename $BASE`
echo "	parent directory of script file.."$PARENT

# Keeps the executing directory as the script root.
cd $BASE

echo

find . -type d -exec ./docbuilddir.sh '{}' \;	
find . -type f \( -name "*.js" -or -name "*.ejs" -or -name "*.sh" \) -exec ./docbuildinner.sh '{}' \;	

#find . -type d -exec docbuildinner '{}' \;	

#sed -e "s/\.\.\\//data\\/scripts\\//" $PARENT/docs.html > $PARENT/docs2.html

#for file in *
#do
 # do something on $file
 #cat "$file"
 #echo $file
#done	



echo -n "output sent to doc_build.txt"	

echo "..done."
