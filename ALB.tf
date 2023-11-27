# # provider "aws" {
# #   region = "us-east-1"  # Replace with your desired region
# # }

# # Create a new security group for the ALB
# resource "aws_security_group" "alb_sg" {
#   name        = "alb-sg"
#   description = "Security group for Application Load Balancer"
# }

# # Allow incoming traffic on port 80 (HTTP) for the ALB
# resource "aws_security_group_rule" "alb_http_ingress" {
#   type        = "ingress"
#   from_port   = 80
#   to_port     = 80
#   protocol    = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]  # Adjust as needed for your network setup
#   security_group_id = aws_security_group.alb_sg.id
# }

# # Create the Application Load Balancer
# resource "aws_lb" "my_alb" {
#   name               = "my-alb"
#   internal           = false
#   load_balancer_type = "application"
#   subnets            = ["subnet-0de6fc8b5c961839c", "subnet-0d028cb74092c9262", "subnet-078a85b6ff2ae26f8"]  # Replace with your subnet IDs
#   enable_deletion_protection = false  # Set to true if you want to enable deletion protection
#   security_groups    = [aws_security_group.alb_sg.id]
# }

# # Define the target group for the ALB
# resource "aws_lb_target_group" "my_target_group" {
#   name        = "my-target-group"
#   port        = 80
#   protocol    = "HTTP"
#   vpc_id      = "vpc-07ccf75c194ce2ca2"  # Replace with your VPC ID
#   target_type = "instance"

#   health_check {
#     path     = "/health-check"  # Replace with your health check path
#     port     = "80"
#     protocol = "HTTP"
#   }
# }

# # Define a data source to fetch the existing EC2 instances by their tags
# data "aws_instances" "existing_instances" {
#   instance_tags = {
#     Name = "CICD-apache"  # Replace with the tag you've used to identify the instances
#     Name = "CICD-apache2"
#     Name = "CICD-apache3"
#   }
# }


# # Attach EC2 instances to the target group
# resource "aws_lb_target_group_attachment" "my_target_group_attachment" {
#   count = length(data.aws_instances.existing_instances.ids)
#   target_group_arn = aws_lb_target_group.my_target_group.arn
#   target_id        = data.aws_instances.existing_instances.ids[count.index]
# }


# # # Define your EC2 instances here
# # resource "aws_instance" "my_instances" {
# #   count = 3  # Number of instances you want to create
# #   ami           = "ami-0d9efc67b4e551155"  # Replace with your desired AMI ID
# #   instance_type = "t2.micro"  # Replace with your desired instance type
# #   subnet_id     = "subnet-0de6fc8b5c961839c"  # Replace with your desired subnet ID

# #   # Add other instance configurations as needed
# # }

# # Output the DNS name of the ALB
# output "alb_dns_name" {
#   value = aws_lb.my_alb.dns_name
# }
