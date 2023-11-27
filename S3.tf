resource "aws_s3_bucket" "jenkins-pkg2-artifactory-nov2023" {
  bucket = "jenkins-pkg2-artifactory-nov2023"

  tags = {
    Name      = "jenkins-pkg2-artifactory-nov2023"
    Terraform = "True"
  }
}