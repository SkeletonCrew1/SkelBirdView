pipeline {
    agent any 
    stages {
        stage('Build') { 
          steps{
            sshagent(credentials : ['birdview-key']) {
              sh 'ssh -v vitalii@192.168.56.106 -o StrictHostKeyChecking=no'
              sh 'echo "hello"'
            }
          }
        }
    }
}