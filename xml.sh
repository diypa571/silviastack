 # diypa571
apache_config_file="/etc/php/8.2/apache2/php.ini"  # Update this path if needed
# Add ".xml" to the extension list
sed -i 's/\(extension=xml.so\)/;\1/' $apache_config_file
sudo systemctl restart apache2
echo "XML support has been enabled for Apache. Restarted Apache service."
