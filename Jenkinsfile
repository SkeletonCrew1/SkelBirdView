pipeline {
    agent any
    environment {
            DB_USER = credentials('BIRDWATCHING_DB_USER')
            DB_PASSWORD = credentials('BIRDWATCHING_DB_PASSWORD')
            DB_NAME = credentials('BIRDWATCHING_DB_NAME')
            DB_HOST = credentials('BIRDWATCHING_DB_HOST')
            AWS_ACCESS_KEY = credentials('AWS_ACCESS_KEY')
            AWS_SECRET_KEY = credentials('AWS_SECRET_KEY')
            S3_BUCKET = credentials('BIRDWATCHING_S3_BUCKET')
            SERVER1 = credentials('SERVER1')
            SERVER2 = credentials('SERVER2')
            SECRET_KEY = credentials('BIRDWATCHING_SECRET_KEY')
            BIRDWATCHING_CERTBOT_CERT = credentials('BIRDWATCHING_CERTBOT_CERT')
            BIRDWATCHING_CERTBOT_KEY = credentials('BIRDWATCHING_CERTBOT_KEY')
        }
// 
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

        stage("Execute Ansible pipeline for load-balancer") {
            steps {
                ansiblePlaybook credentialsId: 'jenkins-key',
                                disableHostKeyChecking: true,
                                inventory: 'playbooks/vars/hosts.yml',
                                playbook: 'playbooks/load-balancer.yml'
            }
        }
    }
    post { 
        always { 
            cleanWs()
        }
    }
}
