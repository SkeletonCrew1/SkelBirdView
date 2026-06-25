#!/bin/bash

# install python
sudo apt update
sudo apt install -y python3 python3-pip python3-venv

# launch application
cd $app_dir
python3 -m venv venv
./venv/bin/pip install -r requirements.txt
sudo nohup ./venv/bin/python app.py > app.log 2>&1 &