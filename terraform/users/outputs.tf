output "user_passwords" {
  value = {
    for user_key, profile in aws_iam_user_login_profile.main :
    user_key => profile.password
  }
  description = "A map of usernames to their initial temporary passwords"
  sensitive   = true
}

output "flask_user_access_key" {
  value = {
    id = aws_iam_access_key.flask-user.id
    secret = aws_iam_access_key.flask-user.secret
  }
  sensitive = true
}

output "jenkins_user_access_key" {
  value = {
    id = aws_iam_access_key.jenkins_user.id
    secret = aws_iam_access_key.jenkins_user.secret
  }
  sensitive = true
}

# Command to output credentials to a json file
# terraform output -json user_passwords > passwords.json
# terraform output -json flask_user_access_key > access_key_flask.json
# terraform output -json jenkins_user_access_key > access_key_jenkins.json
