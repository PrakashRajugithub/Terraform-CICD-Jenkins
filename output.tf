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