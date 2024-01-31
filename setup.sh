#!/bin/bash

sudo apt update


sudo apt install -y apache2


sudo a2enmod rewrite
sudo a2enmod ssl
sudo a2enmod headers

sudo systemctl restart apache2


sudo systemctl status apache2
