#!/bin/bash
#diypa571
# Path to the PHP-FPM pool configuration file
pool_config_file="/etc/php/8.2/fpm/pool.d/www.conf"  # Update this path if needed

# Add ".xml" to the security.limit_extensions line
#sed -i 's/security.limit_extensions = .php .php3 .php4 .php5 .php7/security.limit_extensions = .php .php3 .php4 .php5 .php7 .xml/' $pool_config_file
sed -i 's/;security.limit_extensions = .php .php3 .php4 .php5 .php7/security.limit_extensions = .php .php3 .php4 .php5 .php7 .xml/' $pool_config_file

# Restart PHP-FPM service
sudo systemctl restart php8.2-fpm

echo "XML support has been enabled for PHP-FPM. Restarted php8.2-fpm service."
