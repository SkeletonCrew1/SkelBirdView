#!/bin/bash

HOST_IP=$(hostname -I | awk '{print $2}')

sudo apt update
sudo apt upgrade -y

# install dependencies
sudo apt install -y gnupg software-properties-common unzip wget

# install consul
wget https://releases.hashicorp.com/consul/1.15.0/consul_1.15.0_linux_amd64.zip
unzip consul_1.15.0_linux_amd64.zip
sudo mv consul /usr/local/bin/

# setup consul user and directories
sudo useradd --system --home /etc/consul.d --shell /bin/false consul
sudo mkdir -p /opt/consul
sudo mkdir -p /etc/consul.d
sudo chown -R consul:consul /opt/consul /etc/consul.d /usr/local/bin/consul

# create consul configuration
sudo bash -c 'cat >> /etc/consul.d/consul.hcl <<EOF
datacenter = "dc1"
data_dir = "/opt/consul"

bind_addr = "0.0.0.0"
client_addr = "0.0.0.0"

advertise_addr = "'$HOST_IP'"

bootstrap_expect = 1
server = true
ui = true

EOF'

# copy systemd service file
sudo cp /home/vagrant/config/consul.service /etc/systemd/system/consul.service

# start and enable consul
sudo systemctl daemon-reload
sudo systemctl start consul
sudo systemctl enable consul