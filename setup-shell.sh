#!/bin/bash

echo "=================Apache setup started====================="

yum update -y

yum install java-1.8.0 -y
 
yum install wget -y

wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.0.M9/bin/apache-tomcat-9.0.0.M9.tar.gz

tar -zxf apache-tomcat-9.0.0.M9.tar.gz -C /opt/

cd /opt/

mv apache-tomcat-9.0.0.M9 tomcat

echo "export CATALINA_HOME='/opt/tomcat/'" >> ~/.bashrc

source ~/.bashrc

cd /opt/tomcat/bin/

./startup.sh

cp /home/ec2-user/spring-boot-web-jsp-1.0.war /opt/tomcat/webapps/


echo "=================Apache setup done====================="

echo "=================nginx setup started====================="

yum install nginx -y

setsebool -P httpd_can_network_connect 1

cp /home/ec2-user/nginx.conf /etc/nginx/


sudo systemctl start nginx

echo "=================nginx setup Done====================="

echo "=================Hit IP address in web browser====================="
