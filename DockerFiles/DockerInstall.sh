sudo yum update
sudo yum search docker
sudo yum info docker
sudo yum install docker #once installed try to run below command to check.
docker run hello-world #it shows some error bcoz Docker Daemon is not running. "Unable to find image ---XXX--- See 'docker run --help'" then add username to the docker group by below command.
sudo usermod -aG docker username  #username= ec2-user, root...etc. (NOTE: once added, then logout and login to server)
id username  # to check usename is added to docker or not
newgrp docker
docker --version # to check docker version.

#Uninstalling Docker from Linux
sudo docker system prune -a
sudo yum -y remove docker
docker --version #--tocheck docker present or not

#Docker commands
docker images #to check/list images
docker build -t imagename:latest # to build image. "-t = tag(i.e.,for ex in this line tag is latest)"
docker history imagename:tagname # to check size of layers in image during build
docker run imagename:tagname #it'll run image in front screen and will not be able to run another command in terminal.
docker run -d imagename:tagname #it'll run image in background. "-d = daemon"
docker run -d -p 10000:80 imagename:tagname #to run image with port 10000.
# 10000:80 = httpd/apache port is 80. we are transferring/moving traffic with port 80 to port 10000. Using this we can transfer to N no.of port based on our images count.
#For ex: 10001:80, 10002:80, 10003:80, 10004:80 ...etc
docker stop $(docker ps -q) # to stop all ruuning containers in Docker Host


