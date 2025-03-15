#!/bin/bash
# Author: Diypa571  
# Script to install PHP 8.3 and necessary extensions  

# Update package lists  
sudo apt update  

# Add PHP repository (if not already added)  
sudo add-apt-repository -y ppa:ondrej/php  

# Update package lists again after adding repository  
sudo apt update  

# Install PHP 8.3 and required extensions  
PHP_VERSION="8.3"
sudo apt install -y php${PHP_VERSION} php${PHP_VERSION}-cli php${PHP_VERSION}-fpm \
php${PHP_VERSION}-mysql php${PHP_VERSION}-curl php${PHP_VERSION}-xml php${PHP_VERSION}-mbstring \
php${PHP_VERSION}-zip php${PHP_VERSION}-gd php${PHP_VERSION}-bcmath libapache2-mod-php${PHP_VERSION}  

# Set PHP 8.3 as default  
sudo update-alternatives --set php /usr/bin/php${PHP_VERSION}  

# Restart Apache and PHP-FPM services  
sudo systemctl restart apache2  
sudo systemctl restart php${PHP_VERSION}-fpm  

# Display installed PHP version  
php -v  
