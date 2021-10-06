#!/bin/bash


sudo apt update

sudo apt install -y nginx
echo Creadted: ${time} | sudo tee /var/www/html/index.html
exit