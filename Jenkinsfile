pipeline {
    agent any
    
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