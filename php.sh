#!/bin/bash
#Diypa571, v 8.2 will be installed
PHP_VERSION="8.2"

sudo apt update
sudo add-apt-repository ppa:ondrej/php
sudo apt update
 
sudo apt install php${PHP_VERSION} libapache2-mod-php${PHP_VERSION} php${PHP_VERSION}-mysql

php -v
 
