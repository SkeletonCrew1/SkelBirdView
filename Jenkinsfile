pipeline {
    agent any 
    stages {
        stage('Build') { 
            steps {
                sh 'ssh -v vitalii@192.168.56.106'
                sh 'echo "hello Jenkins"'
            }
        }
    }
}