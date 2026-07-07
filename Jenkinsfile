pipeline {
    agent any
    environment {
        NEWRELIC_API_KEY = credentials('newrelic-api-key')
    }
    stages {
        stage("Execute test playbook") {
            steps {
                ansiblePlaybook credentialsId: 'jenkins-key',
                                 disableHostKeyChecking: true,
                                 playbook: 'playbooks/test_playbook.yml'
            }
        }
    }
}
