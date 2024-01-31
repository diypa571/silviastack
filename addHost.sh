#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

DOMAIN=$1
VHOST_PATH="/etc/apache2/sites-available/$DOMAIN.conf"
WEB_ROOT="/var/www/$DOMAIN/public_html"

sudo mkdir -p $WEB_ROOT
sudo chown -R $USER:$USER $WEB_ROOT
sudo chmod -R 755 $WEB_ROOT


cat <<EOL > $VHOST_PATH
<VirtualHost *:80>
    ServerAdmin webmaster@$DOMAIN
    ServerName $DOMAIN
    DocumentRoot $WEB_ROOT

    <Directory $WEB_ROOT>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/$DOMAIN_error.log
    CustomLog \${APACHE_LOG_DIR}/$DOMAIN_access.log combined
</VirtualHost>
EOL

# Enable virtual host
sudo a2ensite $DOMAIN.conf

# Restart Apache
sudo systemctl restart apache2

# Display status
sudo systemctl status apache2
