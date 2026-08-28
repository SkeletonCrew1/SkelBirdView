## Jenkins configuration

1. Connect to the EC2  Jenkins-server instance
2. Go to `home`
3. Create folder  `mkdir repo` and go there `cd repo` 
4. Run `git init `
5. Clone the repo : `git clone https://github.com/SkeletonCrew1/SkelBirdView.git`
6. Then run `cd SkelBirdView/jenkins-configuration/vars`
7. Create . env `nano .env`
8. Add these secrets(They are strored in AWS Secret manager and starts with):
    ```
    ansible_user_var: ""
    ansible_ssh_pass_var: ""
    jenkins_user_var  ""
    jenkins_pass_var: ""```

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

12. Go to settings -> plugins -> available plugins and install `AWS Secrets Manager Credentials Provider`
13. Add `jenkins-key` in credentials