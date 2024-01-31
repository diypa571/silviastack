#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

DOMAIN=$1
VHOST_PATH="/etc/apache2/sites-available/$DOMAIN.conf"

cat <<EOL > $VHOST_PATH
<VirtualHost *:80>
    ServerAdmin webmaster@$DOMAIN
    ServerName $DOMAIN
    DocumentRoot /var/www/$DOMAIN/public_html

    <Directory /var/www/$DOMAIN/public_html>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/$DOMAIN_error.log
    CustomLog \${APACHE_LOG_DIR}/$DOMAIN_access.log combined
</VirtualHost>
EOL


sudo a2ensite $DOMAIN.conf


sudo systemctl restart apache2


sudo systemctl status apache2
