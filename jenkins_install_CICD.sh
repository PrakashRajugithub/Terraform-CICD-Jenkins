#!/bin/bash
wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum update -y
amazon-linux-extras install java-openjdk11
yum install jenkins -y
systemctl start jenkins
systemctl enable jenkins