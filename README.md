# Birdwatching

## Prerequisites

- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://developer.hashicorp.com/vagrant/install)
- [Packer](https://developer.hashicorp.com/packer/install)
- [Ansible](https://docs.ansible.com/projects/ansible/latest/installation_guide/installation_distros.html)

## Setup Guide

1. Add `.env` containing: `ansible_user_var`, `ansible_ssh_pass_var`, `jenkins_user_var`, `jenkins_pass_var` to `jenkins-configuration/vars/`
2. Execute `run-infrastructure.sh`
3. Open [Jenkins](http://192.168.56.200:8080)
4. Open [Credential page](http://192.168.56.200:8080/manage/credentials/) and add all secrets:
    - `jenkins-key`
    - `DB_USER`
    - `DB_PASSWORD`
    - `DB_NAME`
    - `DB_HOST`
    - `AWS_ACCESS_KEY`
    - `AWS_SECRET_KEY`
    - `S3_BUCKET`
    - `SERVER1`
    - `SERVER2`
5. Add [new pipeline](http://192.168.56.200:8080/view/all/newJob) called `Configure VMs`
    - Definition: `Pipeline script fom SCM`
    - SCM: `Git`
    - Repository URL: `https://github.com/SkeletonCrew1`
    - Branch Specifier: `*/main`
    - Script Path: `Jenkinsfile`

## VMs IP Addresses

- `jenkins`: `192.168.56.200`
- `database`: `192.168.56.105`
- `web-server-1`: `192.168.56.111`
- `web-server-2`: `192.168.56.112`
- `load-balancer`: `192.168.56.106`
