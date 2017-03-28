# Install Laravel Bash Script
[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square)](http://www.opensource.org/licenses/MIT)
> ### PLEASE NOTE:
> I use this locally on my development machine where any directoriesfiles I create as a user are created with the webserver user as group owner.
> It is my first attempt at a shell script that does anything more than echo "Hello World!"

## Description
Simple script (probably with errors and could certaibly be improved upon!)
to install the latest Laravel, create the storage/logs/laravle.log file,
chmod 775 bootstrap and storage directories, chmod 664 the files in
bootstrap and storage.

## Install

Place this file somewhere it can be used globally
e.g. /home/user/bin/
 
Make it executable:
chmod +x installLaravel.sh

# DEPENDENCIES: 
> ###   COMPOSER.
``` bash
Make sure composer is installed before use: https://getcomposer.org.
```
> ###   LARAVEL INSTALLER.
``` bash
With composer installed run:
    composer global require "laravel/installer"
    See https://laravel.com/docs/5.4/installation for more info
```


## Usage

``` bash
installLaravel.sh {appName}
e.g. installLaravel.sh test

If you are in the directory: /var/www/html/Laravel/
this will create the /var/www/html/Larvel/test/ directory,
chmod 775 bootstrap and storage directories
create the storage/logs/laravel.log file
chmod 664 the bootstrap and storage files.

Done.

Let me know if you find it usefull or, even better, how to improve it!
```