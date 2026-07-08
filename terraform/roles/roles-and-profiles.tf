resource "aws_iam_role" "jenkins-role" {
  name = "jenkins-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "jenkins-profile" {
  name = "jenkins-role"
  role = aws_iam_role.jenkins-role.id
}

resource "aws_iam_role" "consul-role" {
  name = "consul-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "consul-profile" {
  name = "consul-profile"
  role = aws_iam_role.consul-role.id
}

resource "aws_iam_role" "ssm-role" {
  name = "general-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

}

resource "aws_iam_instance_profile" "ssm-profile" {
  name = "general-ssm-profile"
  role = aws_iam_role.ssm-role.id
}
