#!/bin/bash
#Diypa571
sudo ufw app list

sudo ufw allow in "Apache"
sudo ufw allow 22

sudo ufw status
