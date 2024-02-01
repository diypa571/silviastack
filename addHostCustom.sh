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

# Skapa error filerna 
sudo tee "$ERRORS_FOLDER/error.php" > /dev/null <<EOL
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
</head>
<body>
    <h1>Error</h1>
    <p>An error occurred. Error code: <?php echo http_response_code(); ?></p>
    <?php
        $error_code = http_response_code();
        $error_message = "An error occurred.";
        switch ($error_code) {
            case 400:
                $error_message = "Bad Request";
                break;
            case 401:
                $error_message = "Unauthorized";
                break;
            case 403:
                $error_message = "Forbidden";
                break;
            case 404:
                $error_message = "Not Found";
                break;
            case 500:
            case 502:
            case 503:
            case 504:
                $error_message = "Internal Server Error";
                break;
        }
    ?>
    <p><?php echo $error_message; ?></p>
</body>
</html>
EOL

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

    # Dynamic error page
    ErrorDocument 400 /errors/error.php
    ErrorDocument 401 /errors/error.php
    ErrorDocument 403 /errors/error.php
    ErrorDocument 404 /errors/error.php
    ErrorDocument 500 /errors/error.php
    ErrorDocument 502 /errors/error.php
    ErrorDocument 503 /errors/error.php
    ErrorDocument 504 /errors/error.php
</VirtualHost>
EOL


sudo a2ensite $DOMAIN.conf
sudo systemctl restart apache2

echo "127.0.0.1 $DOMAIN" | sudo tee -a /etc/hosts > /dev/null

echo "Virtual host for $DOMAIN created successfully, and added to /etc/hosts."
