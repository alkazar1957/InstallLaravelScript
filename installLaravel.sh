#!/bin/bash

# File: installLaravel.sh
#
# Author: Ken Steven (K.Steven@alkazar.net)
# Date:   28 March 2017
#
# Description: Simple script (probably with errors and could be improved upon!)
#              to install the latest Laravel, create the storage/logs/laravle.log file,
#              chmod 775 bootstrap and storage directories, chmod 664 the files in
#              bootstrap and storage.
#
# NOTE:        I rely on the files being created with the group being the web server user
#              so that the chmod allows the app to write to the required files.
#
#
# DEPENDENCIES: COMPOSER.
#               Make sure composer is installed before use: https://getcomposer.org.
#
#               LARAVEL INSTALLER.
#                   With composer installed run:
#                   composer global require "laravel/installer"
#                   See https://laravel.com/docs/5.4/installation for more info
#
#
# Usage:       installLaravel.sh {appName}
# e.g.         installLaravel.sh test
#
#              Be in the directory ABOVE the directory where you want the application to 
#              be installed e.g. /var/www/html/LaravelProjects/



RED='\033[1;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

DIR=$1

# Simple exit function on error 
function exit_on_error
{
    echo -e "\n\n${RED}" "$1" 1>&2
    exit 1
}

# Check to see an app directory has been specified on the command line
# If we have an app directory then run the installer

if [ "$1" = "" ]; then
    echo -e "\nERROR: ${RED}No Installation Directory Specified. (installLaravel directoryname)\n${NC}"
    exit 1
else
    laravel  new ./$1
fi

# If there was an error then exit

if [ "$?" != "0" ]; then 
    echo "Error Msg: $? Laravel NOT created."
    exit 1
else
    echo -e "\n${YELLOW}Laravel$1 created.\n\n    Now going to chmod directories,\n    create storage/laravel/laravel.log \n    then chmod files\n"
fi

# Time to read the message :)
sleep 4


##
# Change directory to the newly created app directory
# Abort if we cannot change directory
# TODO: If we can't change directory then the new laravel
#       application was not created so why no error message
#       from the laravel new command above?
#       Needs to check why.
##
if cd ./$1; then 
    echo  -e "\n${RED} Changed directory to $1.\n"
    sleep 1
else
    exit_on_error "Cannot Change Directory! Aborting now!"
fi


##
# chmod the bootstrap directories to 775 
# to allow the app to write to the rquired files
# Abort if we can't chmod
##
find ./bootstrap/ -type d -exec chmod 775 {} +
if [ "$?" != "0" ]; then 
    echo "Error Msg: $? Could not chmod bootstrap directories. Aborting now."
    exit 1
else
    echo -e " chmod 775 Bootstrap dirctories complete.\n"
    sleep 1
fi

##
# chmod the bootstrap files to 664
# Abort if we can't chmod
##
find ./bootstrap/ -type f -exec chmod 664 {} +
if [ "$?" != "0" ]; then 
    echo "Error Msg: $? Could not chmod directories. Aborting now."
    exit 1
else
    echo -e " chmod 664 Bootstrap Files complete.\n"
    sleep 1
fi

##
# Create the storage/logs/laravel.log file
# Abort if we can't create it
##
touch ./storage/logs/laravel.log
if [ "$?" != "0" ]; then 
    echo "Error Msg: $? Could not create storage/logs/laravel.log. Aborting now."
    exit 1
else
    echo -e "${YELLOW} Laravel Log File created. (storage/logs/laravel.log)\n"
    sleep 1
fi

##
# chmod the storage files to 775
# Abort if we can't chmod
##
find ./storage/ -type d -exec chmod 775 {} +
if [ "$?" != "0" ]; then 
    echo "Error Msg: $? Could not chmod storage directories. Aborting now."
    exit 1
else
    echo -e "${RED} chmod 775 Storage Directories Complete.\n"
    sleep 1
fi

##
# chmod the storage files to 664
# Abort if we can't chmod
##
find ./storage/ -type f -exec chmod 664 {} +
if [ "$?" != "0" ]; then 
    echo "Error Msg: $? Could not chmod storage files. Aborting now."
    exit 1
else
    echo -e "${RED} chmod 664 chmod of Storage Files Complete.\n"
    sleep 1
fi

##
# All Done!
##
echo -e "${NC} WhooHoo Finished.\n"
