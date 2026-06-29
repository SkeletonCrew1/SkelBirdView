pipeline {
    agent any 
    stages {
        stage('Build') { 
          steps{
            sshagent(credentials : ['jenkins-key']) {
              sh 'ssh -v vitalii@192.168.56.106'
              sh 'echo "hello"'
            }
          }
        }
    }
}