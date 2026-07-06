resource "aws_iam_role_policy" "jenkins-sec-man-policy" {
  name = "jenkins-sec-man-policy"
  role = aws_iam_role.jenkins-role.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowJenkinsToGetSecretValues",
            "Effect": "Allow",
            "Action": "secretsmanager:GetSecretValue",
            "Resource": "*"
        },
        {
            "Sid": "AllowJenkinsToListSecrets",
            "Effect": "Allow",
            "Action": "secretsmanager:ListSecrets",
            "Resource": "*"
        },
        {
            "Action": "ec2:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]
  })
}