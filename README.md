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
sudo addHostCustom1.sh applifee.com
bash addHostCustom1.sh applifee.com
systemctl restart apache2

sudo bash addHostCustom1.sh demo.com
systemctl restart apache2

whoami
chown -R $(whoami) /var/www/
chgrp -R www-data /var/www/
chmod -R 755 /var/www/
chmod g+s /var/www/
sudo chown -R $(whoami) /var/www/
sudo chgrp -R www-data /var/www/
sudo chmod -R 755 /var/www/
sudo chmod g+s /var/www/
*****************************
 
 
  
  
