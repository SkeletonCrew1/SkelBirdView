#!/bin/bash

set -euo pipefail

vagrant destroy -f
for vm in $(VBoxManage list vms | awk -F'"' '{print $2}'); do VBoxManage unregistervm "$vm" --delete; done
rm -rf output-golden-image
rm -rf .vagrant
rm -rf VirtualBox\ VMs/*

packer init .

packer build .

vagrant box add --force ubuntu26-golden-image ./output-golden-image/package.box

vagrant up

ansible-playbook ./jenkins-configuration/setup_jenkins.yml
