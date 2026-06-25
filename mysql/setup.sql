-- example values, do not commit actual values to GitHub
CREATE DATABASE flask_stuff;
CREATE USER 'app'@'%' IDENTIFIED BY 'strong_pass';
GRANT ALL PRIVILEGES ON *.* TO 'app'@'%' WITH GRANT OPTION;