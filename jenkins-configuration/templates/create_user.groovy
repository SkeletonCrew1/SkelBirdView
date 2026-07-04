#!groovy

import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstance()

def hudsonRealm = new HudsonPrivateSecurityRealm(false)

hudsonRealm.createAccount("{{ jenkins_user }}","{{ jenkins_pass }}",)
instance.setSecurityRealm(hudsonRealm)
instance.save()
