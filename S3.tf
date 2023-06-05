resource "aws_s3_bucket" "jenkins-pkg-artifactory" {
  bucket = "jenkins-pkg-artifactory"

  tags = {
    Name      = "jenkins-pkg-artifactory"
    Terraform = "True"
  }
}