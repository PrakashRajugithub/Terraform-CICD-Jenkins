resource "aws_security_group" "apache" {
  name        = "allow apache"
  description = "Allow apache inbound traffic"
  vpc_id      = "vpc-0e0816654f0c2ab68"
  #  above VPC I given is Default vpc. We can get our own vpc by Data Source.

  ingress {
    description = "apache"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # In the above line we can give our own IP by using "chomp". For this I have given to outside for practice.
  }

  ingress {
    description = "Alb-Apache"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name      = "CICD-apache-sg"
    Terraform = "True"
  }
}

resource "aws_instance" "apache" {
  ami                    = "ami-02b2e78e9b867ffec"
  instance_type          = "t2.xlarge"
  subnet_id              = "subnet-0136d87b6080f279a"
  vpc_security_group_ids = [aws_security_group.apache.id]
  key_name               = aws_key_pair.CICD.id
  # user_data = file("${path.module}/apache_install.sh")
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install httpd -y
              systemctl start httpd
              systemctl enable httpd
              #amazon-linux-extras install java-openjdk11
              EOF


  # THe above "subnet id" is default, we can give own subnet using Data source.
  # the above "vpc_security_group_ids" is while creating Instance it need SG so we are assigning the SG.
  # During creation we needed key pair so we are calling the key file which we have created in "keyfile.tf".
  # For Userdata also I have done the same as for Key file calling the file using Path Module.

  tags = {
    Name      = "CICD-apache"
    Terraform = "True"
  }

  #  lifecycle {
  #   create_before_destroy = true
  # }

}

resource "aws_ec2_instance_state" "apache" {
    instance_id = aws_instance.apache.id
    state       = "running"
  }