#!/bin/bash

# load sensitive data
source "/home/vagrant/config/sensitive-mysql.env"

# create directory for mysql configuration and log file
mkdir -p /home/vagrant/config/
mkdir -p /home/vagrant/config/security-scanner-logs
touch "$LOG_FILE_PATH_NAME"

# copy mysql configuration file
sudo cp /home/vagrant/config/mysql.hcl /etc/mysql/mysql.conf.d/

# install mysql server and restart it
sudo apt update
sudo apt install -y mysql-server 
sudo systemctl restart mysql

# execute mysql commands to create database, user and grant privileges
sudo mysql -e "${CREATE_DATABASE}${CREATE_USER}${GRANT_PRIVILEGES}${FLUSH_PRIVILEGES}" 2>&1 | tee -a "$LOG_FILE_PATH_NAME"
sudo mysql -e "SHOW DATABASES;" 2>&1 | tee -a "$LOG_FILE_PATH_NAME"
sudo mysql -e "SELECT User, Host FROM mysql.user;" 2>&1 | tee -a "$LOG_FILE_PATH_NAME"