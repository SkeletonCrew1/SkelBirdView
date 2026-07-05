#!/bin/bash

set -euo pipefail

vagrant destroy -f

for vm in $(VBoxManage list vms | awk -F'"' '{print $2}'); do
  VBoxManage unregistervm "$vm" --delete || true
done

rm -rf output-golden-image .vagrant
rm -rf ~/VirtualBox\ VMs/*

ansible-galaxy collection install ansible.windows
ansible-galaxy install datadog.datadog

packer init ./packer/s
packer build ./packer/

vagrant box add --force ubuntu26-golden-image ./output-golden-image/package.box
vagrant up

ansible-playbook -i ./jenkins-configuration/hosts.yml ./jenkins-configuration/setup_jenkins.yml
