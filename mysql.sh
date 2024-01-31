#!/bin/bash

sudo apt install mysql-server


sudo mysql_secure_installation

sudo mysql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
exit

sudo mysql_secure_installation
