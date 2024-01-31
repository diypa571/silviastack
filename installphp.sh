#!/bin/bash

sudo apt update

sudo apt install -y software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install -y php8.2 php8.2-cli php8.2-fpm php8.2-mysql php8.2-curl php8.2-gd php8.2-mbstring php8.2-xml

if [ $? -ne 0 ]; then
    echo "Error: PHP installation failed."
    exit 1
fi


sudo a2enmod php8.2

sudo systemctl restart apache2


php -v


php -m

DOMAIN="example.com"
VHOST_PATH="/etc/apache2/sites-available/$DOMAIN.conf"
WEB_ROOT="/var/www/$DOMAIN/public_html"

sudo sed -i 's/^\s*<FilesMatch \.php$>.*<\/FilesMatch>/\t<FilesMatch \.php$>\n\t\tSetHandler application/x-httpd-php\n\t<\/FilesMatch>/' $VHOST_PATH

sudo chown -R www-data:www-data $WEB_ROOT
sudo chmod -R 755 $WEB_ROOT
