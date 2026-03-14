#!/bin/bash

# ==========================================
# Apache Website Auto Setup Script
# ==========================================

if [ -z "$1" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

DOMAIN=$1
DOCROOT="/var/www/$DOMAIN"
VHOST="/etc/apache2/sites-available/$DOMAIN.conf"

echo "Setting up website for $DOMAIN"

# ------------------------------------------
# Enable required Apache modules
# ------------------------------------------
echo "Enabling Apache modules..."
a2enmod rewrite headers expires deflate >/dev/null

# ------------------------------------------
# Ensure global .htaccess support
# ------------------------------------------
echo "Configuring Apache global settings..."

APACHE_CONF="/etc/apache2/apache2.conf"

if ! grep -q "AllowOverride All" $APACHE_CONF; then
sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' $APACHE_CONF
fi

# ------------------------------------------
# Create document root
# ------------------------------------------
if [ ! -d "$DOCROOT" ]; then
    echo "Creating document root..."
    mkdir -p "$DOCROOT"

    cat > "$DOCROOT/index.php" <<EOF
<?php
echo "Welcome to $DOMAIN";
?>
EOF
fi

# ------------------------------------------
# Create Virtual Host
# ------------------------------------------
if [ ! -f "$VHOST" ]; then
echo "Creating Apache virtual host..."

cat > "$VHOST" <<EOF
<VirtualHost *:80>

ServerName $DOMAIN
ServerAlias www.$DOMAIN
DocumentRoot $DOCROOT

<Directory $DOCROOT>
Options FollowSymLinks
AllowOverride All
Require all granted
</Directory>

ErrorLog \${APACHE_LOG_DIR}/${DOMAIN}_error.log
CustomLog \${APACHE_LOG_DIR}/${DOMAIN}_access.log combined

</VirtualHost>
EOF

fi

# ------------------------------------------
# Enable site
# ------------------------------------------
a2ensite "$DOMAIN.conf" >/dev/null

# ------------------------------------------
# Create default .htaccess
# ------------------------------------------
HTACCESS="$DOCROOT/.htaccess"

if [ ! -f "$HTACCESS" ]; then

cat > "$HTACCESS" <<EOF
RewriteEngine On

# Ignore existing files
RewriteCond %{REQUEST_FILENAME} -f [OR]
RewriteCond %{REQUEST_FILENAME} -d
RewriteRule ^ - [L]

# Clean URL routing
RewriteRule ^([^/]+)/?$ \$1.php [L]
EOF

fi

# ------------------------------------------
# Fix permissions
# ------------------------------------------
chown -R www-data:www-data "$DOCROOT"
chmod -R 755 "$DOCROOT"

# ------------------------------------------
# Restart Apache once
# ------------------------------------------
systemctl reload apache2

echo "--------------------------------------"
echo "Website ready:"
echo "http://$DOMAIN"
echo "Document root: $DOCROOT"
echo "--------------------------------------"
