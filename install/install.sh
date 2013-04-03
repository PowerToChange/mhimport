#!/bin/bash

PWD=`pwd`
BASE=`basename $PWD`

if [ "$BASE" == "install" ];
then

    cd ..
    echo "Installing node modules..."
    npm install ansi-color
    npm install ejs
    npm install express@2.5.9
    npm install socket.io@0.9.0
    npm install mysql
	npm install faye
    npm install jsdom # For node-cas
    npm install jquery-deferred
    npm install temp
    npm install eventemitter2
    npm install async
    npm install nodeunit
    npm install request # For node-mandrill
    npm install underscore # For node-mandrill
    
    cd install
    echo "Starting install server..."
    echo "Please start your web browser and go to http://localhost:8088/appDevInstall"
    node app_install.js
    if [ $? == 0 ];
    then
        cd ..
        echo "Starting appDev server..."
        node app.js
    else
        echo "Installation error."
    fi

else
    echo "Please chdir to the install directory before running this."
fi