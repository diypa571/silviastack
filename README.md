
Installation av Apache, php,mysql och ufw

Har skrivit förljande bash skripter för att automatisera installatonen av apache,php och mysql.

För att det ska användas för produktion, det behövs nftables konfigurerat på rätt sätt.

 
 sudo bash install.sh
 
 sudo bash  php.sh
 
 sudo bas mysql.sh
 
  sudo bash addHost.sh test.com
  
  sudo bash addHost.sh test1.com
  
  sudo bash addHost.sh test2.com

 sudo bash ufw.sh

 

 
 
