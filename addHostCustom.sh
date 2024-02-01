#!/bin/bash
# Diypa571

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
ERRORS_FOLDER="$WEB_ROOT/errors"

sudo mkdir -p $ERRORS_FOLDER
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

    ErrorDocument 400 /errors/error_400.html
    ErrorDocument 401 /errors/error_401.html
    ErrorDocument 403 /errors/error_403.html
    ErrorDocument 404 /errors/error_404.html
    ErrorDocument 500 /errors/error_500.html

    <Directory "$WEB_ROOT/html">
        AllowOverride All
    </Directory>
</VirtualHost>
EOL

# Enable virtual host and restart Apache
sudo a2ensite $DOMAIN.conf
sudo systemctl restart apache2

echo "127.0.0.1 $DOMAIN" | sudo tee -a /etc/hosts > /dev/null

echo "Virtual host for $DOMAIN created successfully, and added to /etc/hosts."
