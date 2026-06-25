#!/bin/bash

sudo apt update
sudo apt install mysql-server -y
sudo systemctl start mysql
sudo systemctl enable mysql

cp /vagrant_data/setup.sql setup.sql
sudo cp /vagrant_data/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
chmod 755 setup.sql
sudo mysql < "setup.sql"
sudo systemctl restart mysql