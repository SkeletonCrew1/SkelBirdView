# Birdwatching Setup Guide

## Prerequirments

- Login in AWS account using command ```aws configure```
- [Packer](https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli) installed 


## Build image 
1. Check if right key are inserted in `playbooks/vars/users.yml`
2. Go to `packer/` directory
3. Run `packer init .`
4. Run `packer build .`



## Generate SSL certificate 
Follow this doc to create ssl certificate: 
https://certbot.eff.org/instructions?ws=other&os=ubuntufocal

After succefully creating the certifacte , you shoud get two the context from 2 files:
1. `/etc/letsencrypt/live/<your-domain-name>/fullchain.pem` - certificate 

2. `/etc/letsencrypt/live/<your-domain-name>/privkey.pem` - private key

Save them to add to the AWS Secrets Manager later.


## Add secrets to AWS Secrets manager

Add following secrets with tag key `jenkins:credentials:type` and value `string`:
- `BIRDWATCHING_CERTBOT_KEY` - key you generated earlier alongside a certificate (save the value as plain text!)
- `BIRDWATCHING_CERTBOT_CERT` - certificate you generated earlier (save the value as plain text!)
- `BIRDWATCHING_SECRET_KEY` - key required by FLask 
- `BIRDWATCHING_S3_BUCKET` - name of the bucket for image storage
- `AWS_SECRET_KEY`
- `AWS_ACCESS_KEY`
- `BIRDWATCHING_DB_NAME` 
- `BIRDWATCHING_DB_PASSWORD`
- `BIRDWATCHING_DB_USER`
- `BIRDWATCHING_JENKINS_USER` 
- `BIRDWATCHING_JENKINS_PASS` 
SERVER1,SERVER2 and BIRDWATCHING_DB_HOST will be created via terraform with appropriate tags

Add `BIRDWATCHING_ANSIBE_SSH_PASS` (ssh private key used by jenkins to connect to other machines) without any tags

## Create jenkins

1. Go to `terraform/environments/developer-infrastructure`
2. Run `terraform init` 
3. Run `terraform validate` and check for any errors
4. If step `3` succeded without any errors, run `terrafrom apply`. Check the resources that will be created and approve by typping `yes`


## Jenkins configuration

1. Connect to the EC2  Jenkins-server instance
2. Go to `home`
3. Create folder  `mkdir repo` and go there `cd repo` 
4. Run `git init `
5. Clone the repo : `git clone https://github.com/SkeletonCrew1/SkelBirdView.git`
6. Then run `cd SkelBirdView/jenkins-configuration/vars`
7. Create . env `nano .env`
8. Add these secrets(They are strored in AWS Secret manager and starts with): 
- ```jenkins_user_var  "<your-user>"``` (stored in AWS as `BIRDWATCHING_JENKINS_USER`)   
- ```jenkins_pass_var: "<your-pass>"```  (stored in AWS as `BIRDWATCHING_JENKINS_PASS`)
9. Go back : `cd ..`
10. Install ansible: 
    ```sudo apt update
    sudo apt install software-properties-common
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install ansible```
11. Run playbook: ```ansible-playbook setup_jenkins.yml```
12. To login run this command : ```aws ssm start-session \
    --target <EC2-instance-ID> \
    --document-name AWS-StartPortForwardingSession \
    --parameters '{"portNumber":["8080"],"localPortNumber":["8080"]}'```

12. Go to settings -> plugins -> available plugins and install [AWS Secrets Manager Credentials Provider](https://plugins.jenkins.io/aws-secrets-manager-credentials-provider/) and [Pipeline](https://plugins.jenkins.io/workflow-aggregator/
) 
13. Add `jenkins-key` in credentials (Stored in AWS Secrets manager as BIRDWATCHING_ANSIBE_SSH_PASS)


## Create Terraform pipeline

Create a pipeline with name `Create-EC2s dev` 

Repo link : `https://github.com/SkeletonCrew1/SkelBirdView.git`

Branch : `main` 
Pipeline file name : `Terraform-Pipeline`

Execute the pipeline. After the start you should see Apply or Abort option.
Click apply 

## Change hosts 

1. Switch to `SKEL2-100-changed-hosts` branch

2. Go to AWS EC2 instances and change the IPs for  machines you've created (playbooks/vars/hosts.yml)

3. Commit and push the changes


## Create pipeline for EC2s configuration 

Create a pipeline with name `Configure EC2s dev` 

Repo link : `https://github.com/SkeletonCrew1/SkelBirdView.git`

Branch : `SKEL2-100-changed-hosts` 
Pipeline file name : `Terraform-Pipeline`

Execute the pipeline. 
