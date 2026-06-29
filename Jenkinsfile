pipeline {
    agent any 
    stages {
        stage('Build') { 
          steps{
            sshagent(credentials : ['jenkins-key']) {
              sh 'ssh -v vitalii@192.168.56.106 -o StrictHostKeyChecking=no'
              sh 'ansible-playbook ./playbooks/database.yml'
            }
          }
        }
    }
}