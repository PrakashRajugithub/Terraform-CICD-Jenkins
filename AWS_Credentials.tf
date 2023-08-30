provider "aws" {
  region = "ap-southeast-1"  # Use your desired AWS region
}

data "aws_caller_identity" "current" {}
