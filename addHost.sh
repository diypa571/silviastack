#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (use sudo)"
    exit 1
fi


if [ -z "$1" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi


DOMAIN=$1


WEB_ROOT="/var/www/$DOMAIN"
sudo mkdir $WEB_ROOT
sudo chown -R $USER:$USER $WEB_ROOT


VHOST_FILE="/etc/apache2/sites-available/$DOMAIN.conf"
sudo touch $VHOST_FILE


cat <<EOL | sudo tee $VHOST_FILE > /dev/null
<VirtualHost *:80>
    ServerAdmin webmaster@$DOMAIN
    ServerName $DOMAIN
    ServerAlias www.$DOMAIN
    DocumentRoot $WEB_ROOT
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOL

# Enable the virtual host
sudo a2ensite $DOMAIN.conf

# Restart Apache to apply changes
sudo systemctl restart apache2

echo "Virtual host for $DOMAIN created successfully."
