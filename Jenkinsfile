pipeline {
    agent any 
    stages {
        stage('Configure-database') { 
          steps{
            sshagent(credentials : ['jenkins-key']) {
              sh 'pwd'
              sh 'ls -la'
              sh 'echo "helllloooooo"'
            }
          }
        }
    }
}
    