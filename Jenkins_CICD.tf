resource "aws_security_group" "CICD" {
  name        = "allow CICD"
  description = "Allow CICD inbound traffic"
  vpc_id      = "vpc-0e0816654f0c2ab68"
#  above VPC I given is Default vpc. We can get our own vpc by Data Source.

  ingress {
    description = "CICD"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   
    # In the above line we can give our own IP by using "chomp". For this I have given to outside for practice.
  }

ingress {
    description = "Alb-CICD"
    from_port   = 8080
    to_port     = 8080
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
    Name      = "CICD-sg"
    Terraform = "True"
  }
}

resource "aws_instance" "CICD" {
  ami           = "ami-02b2e78e9b867ffec"
  instance_type = "c5.2xlarge"
  subnet_id = "subnet-0136d87b6080f279a"
  vpc_security_group_ids = [aws_security_group.CICD.id]
  iam_instance_profile = aws_iam_instance_profile.jenkins_access_storage.name
  key_name = aws_key_pair.CICD.id
  # user_data = file("${path.module}/jenkins_install_CICD.sh")

  user_data              = <<-EOF
              #!/bin/bash
              wget -O /etc/yum.repos.d/jenkins.repo \
                   https://pkg.jenkins.io/redhat-stable/jenkins.repo
              rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
              yum update -y
              amazon-linux-extras install java-openjdk11
              yum install jenkins -y
              systemctl start jenkins
              systemctl enable jenkins
              EOF
    
# Check the First two lines of commands (Repo and rpm) these will be changed during Jenkins new relese
# THe above "subnet id" is default, we can give own subnet using Data source.
# the above "vpc_security_group_ids" is while creating Instance it need SG so we are assigning the SG.
# During creation we needed key pair so we are calling the key file which we have created in "keyfile.tf".
  
  tags = {
    Name = "Stage-CICD-Jenkins"
    Terraform ="True"
  }
  #  lifecycle {
  #   create_before_destroy = true
  # }

}

resource "aws_ec2_instance_state" "CICD" {
  instance_id = aws_instance.CICD.id
  state       = "running"
}

# The aboove resource (i.e.,aws_ec2_instance_state) should be create separately and should not create inside of the other Resource.
# In the Arguments, if we need to start the stopped instance use "running" and use "stopped" to shutdown/stop ec2 instance.
