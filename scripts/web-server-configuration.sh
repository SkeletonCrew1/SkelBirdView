#!/bin/bash

# install python
sudo apt update
sudo apt install -y python3 python3-pip python3-venv

# create configuration file for consul
HOST_NAME=$(hostname)
sudo mkdir -p /etc/consul.d
sudo tee /etc/consul.d/web-server.hcl > /dev/null <<EOF
{
  "service": {
    "id": "web-server-$HOST_NAME",
    "name": "web",
    "tags": ["web-server"],
    "port": 80
  }
}
EOF

# launch application
cd $app_dir
python3 -m venv venv
./venv/bin/pip install -r requirements.txt
nohup ./venv/bin/python app.py > app.log 2>&1 &