#!/bin/bash

# install nginx and dependencies
sudo apt update -y
sudo apt install -y nginx unzip wget

# start nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# remove default nginx configuration
sudo rm -f /etc/nginx/sites-enabled/default

# install consul
wget https://releases.hashicorp.com/consul-template/0.35.0/consul-template_0.35.0_linux_amd64.zip
unzip consul-template_0.35.0_linux_amd64.zip
sudo mv consul-template /usr/local/bin/

# create directory for consul template and copy template there
sudo mkdir -p /etc/consul-template
sudo cp /home/vagrant/config/load-balancer.conf.ctmpl /etc/consul-template/

# copy systemd service file
sudo cp /home/vagrant/config/consul-template.service /etc/systemd/system/consul-template.service

# start and enable consul template
sudo systemctl daemon-reload
sudo systemctl enable consul-template