#!/bin/bash


sudo apt update

sudo apt install apache2


sudo systemctl enable apache2

sudo systemctl start apache2

sudo ufw allow in "Apache"

sudo ufw status
