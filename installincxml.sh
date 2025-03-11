#!/bin/bash
# Diypa571


sudo apt update
sudo apt install apache2
sudo systemctl enable apache2
sudo systemctl start apache2

sudo ufw allow in "Apache"
sudo ufw allow 22

apache_config_file="/etc/apache2/apache2.conf" 

if ! grep -q "SetHandler application/x-httpd-php" "$apache_config_file"; then
    echo "<FilesMatch \.xml$>" | sudo tee -a "$apache_config_file" > /dev/null
    echo "    SetHandler application/x-httpd-php" | sudo tee -a "$apache_config_file" > /dev/null
    echo "</FilesMatch>" | sudo tee -a "$apache_config_file" > /dev/null

    echo "Added configuration to handle XML files with PHP in $apache_config_file"
fi

sudo systemctl restart apache2

sudo ufw status
