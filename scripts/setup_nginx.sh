#!/bin/bash

sudo apt update
sudo apt install -y nginx
# shellcheck disable=SC2154
echo Created: "${time}" | sudo tee /var/www/html/index.html
exit 0