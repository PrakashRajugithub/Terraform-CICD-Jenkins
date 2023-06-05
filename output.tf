# This OUTPUT file is to get final output using terraform. Not to sign in console.
# ####################Syntax######################
#       output "name" {
#           value = aws_resource.resource_name.attribute_value
#         }
# ################################################

output "CICDpubIP" {
    value = aws_instance.CICD.public_ip
  }

output "apachepubIP" {
    value = aws_instance.apache.public_ip
  }

  output "CICDdns" {
    value = aws_instance.CICD.public_dns
  }

output "apachedns" {
    value = aws_instance.apache.public_dns
  }