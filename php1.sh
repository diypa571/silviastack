
#!/bin/bash
# Author: Diypa571
# Script to install PHP 8.3 and necessary extensions

PHP_VERSION="8.3"

# Update package lists
sudo apt update

# Install software-properties-common if not already installed
sudo apt install -y software-properties-common lsb-release ca-certificates apt-transport-https

# Add Ondřej Surý's PHP PPA
sudo add-apt-repository ppa:ondrej/php -y

# Update package lists again
sudo apt update

# Install PHP 8.3 and extensions
sudo apt install -y php${PHP_VERSION} php${PHP_VERSION}-cli php${PHP_VERSION}-fpm \
php${PHP_VERSION}-mysql php${PHP_VERSION}-curl php${PHP_VERSION}-xml php${PHP_VERSION}-mbstring \
php${PHP_VERSION}-zip php${PHP_VERSION}-gd php${PHP_VERSION}-bcmath libapache2-mod-php${PHP_VERSION}

# Set PHP 8.3 as the default version
sudo update-alternatives --set php /usr/bin/php${PHP_VERSION}

# Restart services
sudo systemctl restart apache2
sudo systemctl restart php${PHP_VERSION}-fpm

# Display installed PHP version
php -v
