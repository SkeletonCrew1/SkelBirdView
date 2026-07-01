pipeline {
    agent any
    environment {
            DB_USER = credentials('DB_USER')
            DB_PASSWORD = credentials('DB_PASSWORD')
            DB_NAME = credentials('DB_NAME')
            DB_HOST = credentials('DB_HOST')
            AWS_ACCESS_KEY = credentials('AWS_ACCESS_KEY')
            AWS_SECRET_KEY = credentials('AWS_SECRET_KEY')
            S3_BUCKET = credentials('S3_BUCKET')
        }
    stages {
        stage("Execute Ansible pipeline for DB") {
            steps {
                ansiblePlaybook credentialsId: 'jenkins-key',
                                 disableHostKeyChecking: true,
                                 inventory: 'playbooks/vars/hosts.yml',
                                 playbook: 'playbooks/database.yml'
            }
        }
        stage("Execute Ansible pipeline for web-servers") {
            steps {
                ansiblePlaybook credentialsId: 'jenkins-key',
                                 disableHostKeyChecking: true,
                                 inventory: 'playbooks/vars/hosts.yml',
                                 playbook: 'playbooks/web-servers.yml'
            }    
        }    
    }
}