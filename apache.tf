resource "aws_security_group" "apache" {
  name        = "allow apache"
  description = "Allow apache inbound traffic"
  vpc_id      = "vpc-00033bc2195cf6520"
  #  above VPC I have given Default vpc. We can get our own vpc by Data Source.

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

  ingress {
    description = "tomcat"
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
    Name      = "CICD-apache-sg"
    Terraform = "True"
  }
}

resource "aws_instance" "apache" {
  # ami                    = "ami-02b2e78e9b867ffec"
  ami                    = "ami-02453f5468b897e31"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-012eec82a999af6d5"
  vpc_security_group_ids = [aws_security_group.apache.id]
  key_name               = aws_key_pair.CICD.id
  # user_data = file("${path.module}/apache_install.sh")
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install httpd -y
              systemctl start httpd
              systemctl enable httpd
              amazon-linux-extras install java-openjdk11
              sudo wget https://aws-codedeploy-ap-southeast-1.s3.amazonaws.com/latest/install
              sudo chmod 755 ./install
              sudo ./install auto
              sudo systemctl start codedeploy-agent
              sudo systemctl enable codedeploy-agent
              sudo pip install awscli
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
  state       = "stopped"
}