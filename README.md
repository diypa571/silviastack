      adduser ubuntu
      usermod -aG sudo ubuntu
      rsync --archive --chown=ubuntu:ubuntu ~/.ssh /home/ubuntu
      
      
      Using these bash scripts, you will be able to automaticly install apache2, php and mysql.
      
      And yes,it is possible   installing it on virtual machines AWS, GCP, Linode and Digitalocean provides.
      
      
      Installation av Apache, php,mysql och ufw
      
      Har skrivit förljande bash skripter för att automatisera installatonen av apache2,php och mysql.
      
      För att det ska användas för produktion, det behövs nftables konfigurerat på rätt sätt.
      
      
      sudo bash install.sh
      
      sudo bash  php.sh
      
      sudo bas mysql.sh
      
      sudo bash addHost.sh test.com
      
      sudo bash addHost.sh test1.com
      
      sudo bash addHost.sh test2.com
      
      sudo bash ufw.sh
      
      - 👀  ********** Mer avancerat
      
      
      
      sudo bash installincxml.sh 
      
      sudo bash php.sh
      
      sudo bash mysql.sh
      
      sudo bash addHostCustom.sh test.com
      
      sudo bash ufw.sh
      
      
      ******************
      sudo bash install.sh 
      sudo ufw allow 22
      sudo ufw enable
      sudo ufw status
      sudo bash php.sh
      
      sudo bash php.sh 
      bash mysql.sh 
      systemctl reload apache2
      sudo bash addHostCustom1.sh applifee.com
      systemctl restart apache2
      
      sudo bash addHostCustom1.sh demo.com
      systemctl restart apache2
      
      whoami
    sudo  chown -R $(whoami) /var/www/
    sudo  chgrp -R www-data /var/www/
    sudo  chmod -R 755 /var/www/
     sudo chmod g+s /var/www/
      
      *****************************


      
              No php extentions...
      sudo nano /etc/apache2/sites-available/demo.se.conf


      <VirtualHost *:80>
    ServerAdmin webmaster@demo.se
    ServerName demo.se
    ServerAlias www.demo.se
    DocumentRoot /var/www/demo.se

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    ErrorDocument 400 /errors/400.html
    ErrorDocument 401 /errors/401.html
    ErrorDocument 403 /errors/403.html
    ErrorDocument 404 /errors/404.html
    ErrorDocument 500 /errors/500.html

    <Directory "/var/www/demo.se">
        AllowOverride All
        Require all granted
    </Directory>
      </VirtualHost>



      htaccess
      # Enable rewriting
RewriteEngine On

# Ensure base path
RewriteBase /

# 1️⃣ Redirect URLs ending with .php to the clean version
RewriteCond %{THE_REQUEST} \s/+(.+?)\.php[\s?]
RewriteRule ^ %1 [R=301,L]

# 2️⃣ Internally rewrite clean URLs to .php files (even in subfolders)
RewriteCond %{REQUEST_FILENAME} !-d
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME}.php -f
RewriteRule ^(.+)$ $1.php [L,QSA]

# 3️⃣ Redirect /index or /index.php to /
RewriteCond %{THE_REQUEST} \s/+(.*/)?index(\.php)?[\s?]
RewriteRule ^ %1 [R=301,L]

      
      
