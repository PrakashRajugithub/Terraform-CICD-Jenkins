sudo yum update -y
sudo yum install wget unzip -y
sudo amazon-linux-extras install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo  amazon-linux-extras | grep postgre
sudo tee /etc/yum.repos.d/pgdg.repo<<EOF
[pgdg12]
name=PostgreSQL 12 for RHEL/CentOS 7 - x86_64
baseurl=https://download.postgresql.org/pub/repos/yum/12/redhat/rhel-7-x86_64
enabled=1
gpgcheck=0
EOF
sudo yum makecache
sudo yum install postgresql12 postgresql12-server -y
sudo /usr/pgsql-12/bin/postgresql-12-setup initdb
sudo systemctl enable --now postgresql-12
systemctl status postgresql-12
psql -c "alter user postgres with password 'Raju@335'"
exit
# ++++++++++++++++++++++++
sudo su - postgres
createuser sonar
psql
ALTER USER sonar WITH ENCRYPTED password 'sonar';
CREATE DATABASE sonarqube OWNER sonar;
GRANT ALL PRIVILEGES ON DATABASE sonarqube to sonar; 
\q
exit
# ========================

# ++++++++++
sudo useradd sonar
sudo passwd sonar
# ==========

# +++++++++
cd /opt
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.1.0.47736.zip
sudo unzip sonarqube-9.1.0.47736.zip
sudo mv sonarqube-9.1.0.47736 sonarqube
# =========

# +++++++++++++
sudo groupadd sonar
sudo chown -R sonar:sonar /opt/sonarqube
sudo vi /opt/sonarqube/conf/sonar.properties
        sonar.jdbc.username=sonar
        sonar.jdbc.password=sonar
sudo vi /opt/sonarqube/bin/linux-x86-64/sonar.sh
        RUN_AS_USER=sonar
# ================

# +++++++++++++++++++++++
sudo vi /etc/systemd/system/sonar.service
        [Unit] 
        Description=SonarQube service 
        After=syslog.target network.target 
        [Service] 
        Type=forking 
        ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start 
        ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop 
        User=sonar 
        Group=sonar 
        Restart=always 
        [Install] 
        WantedBy=multi-user.target
sudo systemctl daemon-reload
sudo systemctl enable --now sonar
sudo systemctl status sonar


# SonarQube TOken (373d44a8be81ec0591a753b6b32f6c16c9efac34)








