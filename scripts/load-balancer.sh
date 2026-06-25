#!/bin/bash

sudo apt update
sudo apt install nginx -y

sudo /bin/bash -c 'export WEB_SERVER_1_IP="'$WEB_SERVER_1_IP'"; export WEB_SERVER_2_IP="'$WEB_SERVER_2_IP'"; envsubst < /vagrant_data/default.template > /etc/nginx/sites-available/default'

sudo systemctl restart nginx