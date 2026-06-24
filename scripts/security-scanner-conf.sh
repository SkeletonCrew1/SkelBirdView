#!/bin/bash

LOG_FILE_PATH_NAME="/home/vagrant/security-scanner-logs/security-scan-$(hostname).log"
cd /home/vagrant/security-scanner-logs


# install trivy
sudo apt update -y
sudo apt install wget gnupg -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt update
sudo apt install trivy -y

# scan home directory for vulnerabilities and misconfigurations
trivy fs --scanners misconfig,vuln,config /home -f json 2>&1 | tee "$LOG_FILE_PATH_NAME"
