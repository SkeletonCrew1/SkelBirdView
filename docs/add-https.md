add snap on the machine
remove all old certbot packages: sudo apt remove certbot
install certbot :sudo snap install --classic certbot
ensure the certbot can be run :sudo ln -s /snap/bin/certbot /usr/local/bin/certbot
