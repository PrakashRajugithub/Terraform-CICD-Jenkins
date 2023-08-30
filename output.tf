# This OUTPUT file is to get final output using terraform. Not to sign in console.
# ####################Syntax######################
#       output "name" {
#           value = aws_resource.resource_name.attribute_value
#         }
# ################################################

output "CICDpubIP" {
  value = aws_instance.CICD.public_ip
}

output "CICDpvtIP" {
  value = aws_instance.CICD.private_ip
}

output "apachepubIP" {
  value = aws_instance.apache.public_ip
}

output "apachepvtIP" {
  value = aws_instance.apache.private_ip
}

output "CICDdns" {
  value = aws_instance.CICD.public_dns
}

output "apachedns" {
  value = aws_instance.apache.public_dns
}

output "aws_account_number" {
  value = data.aws_caller_identity.current.account_id
}


# Output "CICDStartStatus"{
#   value = aws_ec2_instance_state.JenkinsStartStop.start.id
# }

#  Output "CICDStopStatus"{
#   value = aws_ec2_instance_state.JenkinsStartStop.stopped.id
# }

# Output "apacheStartStatus"{
#   value = aws_ec2_instance_state.apache.start.id
#     }

#  Output "apacheStopStatus"{
#   value = aws_ec2_instance_state.JenkinsStartStop.stopped.id
# }