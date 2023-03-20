#!/bin/bash
yum update -y
yun install httpd -y
systemctl start httpd
systemctl enable httpd