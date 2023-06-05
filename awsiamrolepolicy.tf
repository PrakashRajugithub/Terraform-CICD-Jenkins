# role

resource "aws_iam_role" "jenkins_access_storage" {
  name = "jenkins_access_storage"

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

  tags = {
    Name      = "EC2toS3Role"
    Terraform = "True"
  }

}

# policy

resource "aws_iam_role_policy" "jenkins_access_storage" {
  name = "jenkins_access_storage"
  role = aws_iam_role.jenkins_access_storage.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

#   tags = {
#     Name      = "EC2toS3Policy"
#     Terraform = "True"
#   }

}

# attach policy to role

resource "aws_iam_role_policy_attachment" "jenkins_access_storage" {
  role       = aws_iam_role.jenkins_access_storage.name
  policy_arn = aws_iam_role.jenkins_access_storage.arn
}

# attach role to EC2

resource "aws_iam_instance_profile" "jenkins_access_storage" {
  name = "jenkins_access_storage"
  role = aws_iam_role.jenkins_access_storage.name
}