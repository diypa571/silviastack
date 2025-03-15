#!/bin/bash

# Check if domain name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

DOMAIN=$1
DOCROOT="/var/www/$DOMAIN"

# Enable mod_rewrite in Apache
echo "Enabling mod_rewrite..."
a2enmod rewrite
systemctl restart apache2

# Create document root if it doesn't exist
if [ ! -d "$DOCROOT" ]; then
    mkdir -p "$DOCROOT"
    echo "<?php echo 'Welcome to $DOMAIN'; ?>" > "$DOCROOT/index.php"
fi

# Set up virtual host configuration
VHOST_CONF="/etc/apache2/sites-available/$DOMAIN.conf"

echo "Creating virtual host for $DOMAIN..."
echo "<VirtualHost *:80>
    ServerName $DOMAIN
    DocumentRoot $DOCROOT

    <Directory \"$DOCROOT\">
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog /var/log/apache2/${DOMAIN}_error.log
    CustomLog /var/log/apache2/${DOMAIN}_access.log combined
</VirtualHost>" > "$VHOST_CONF"

# Enable the site
a2ensite "$DOMAIN.conf"

# Create .htaccess for clean URLs
HTACCESS="$DOCROOT/.htaccess"
echo "Creating .htaccess for clean URLs..."
echo "RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^([^/]+)/?$ $1.php [L]" > "$HTACCESS"

# Restart Apache to apply changes
echo "Restarting Apache..."
systemctl restart apache2

echo "Setup complete! You can now access http://$DOMAIN"
