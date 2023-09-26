resource "aws_s3_bucket" "jenkins-pkg1-artifactory-oct2023" {
  bucket = "jenkins-pkg1-artifactory-oct2023"

  tags = {
    Name      = "jenkins-pkg1-artifactory-oct2023"
    Terraform = "True"
  }
}