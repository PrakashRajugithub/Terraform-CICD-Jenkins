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
