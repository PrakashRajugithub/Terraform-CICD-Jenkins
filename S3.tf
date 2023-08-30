resource "aws_s3_bucket" "jenkins-pkg1-artifactory" {
  bucket = "jenkins-pkg1-artifactory"

  tags = {
    Name      = "jenkins-pkg1-artifactory"
    Terraform = "True"
  }
}