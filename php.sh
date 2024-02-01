#!/bin/bash
#Diypa571
PHP_VERSION="8.2"


sudo add-apt-repository ppa:ondrej/php
sudo apt update

sudo apt install php${PHP_VERSION} libapache2-mod-php${PHP_VERSION} php${PHP_VERSION}-mysql
pool_config_file="/etc/php/${PHP_VERSION}/fpm/pool.d/www.conf"

sudo apt update
sudo apt install php${PHP_VERSION} libapache2-mod-php${PHP_VERSION} php${PHP_VERSION}-mysql

php -v
echo "Pool configuration file path: $pool_config_file"
