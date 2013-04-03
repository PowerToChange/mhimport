#!/bin/bash
# This file is a batch script to create the appDev documentation locally.
# Documentation is created from code comments

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

rm -rf ../documentjs/
rm -rf ../steal/

echo "	copying current version of documentjs & steal.."
cp -r data/scripts/documentjs ../
cp -r data/scripts/steal ../

# call the documentjs script
cd ..
documentjs/doc $PARENT>$PARENT/docs_output.txt&

echo -n "	rendering documentation on process "$!

for (( ; ; ))
do
	TESTDONE=`ps ax | grep -v grep | grep $!`
	
	if [ "$TESTDONE" = "" ]
	then
		break
	fi
	
	sleep 2
	echo -n "."	
done

echo

sed -e "s/\.\.\\//data\\/scripts\\//" $PARENT/docs.html > $PARENT/docs2.html
rm $PARENT/docs.html
mv $PARENT/docs2.html $PARENT/docs.html

echo "	clean up.."
rm -rf documentjs
rm -rf steal

echo "	documentjs output sent to docs_output.txt for debugging purposes.."
