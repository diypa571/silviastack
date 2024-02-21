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


Website folder::::     /var/www/test.com
 
 
  
  
