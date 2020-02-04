#setting the Base Image using FROM directive
FROM centos:centos6

#Author Name
MAINTAINER AhmarSharif

#Updating repo sources
RUN yum -y update

############################ START PYTHON INSTALLATION ####################################

#Installing wget to download files from provided locations
RUN yum install wget -y

#Installing python related libraries
RUN yum install gcc -y

#changing directory
RUN cd /usr/src

#Downloading python 2.7.10 file and perform extraction using tar
RUN wget https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz && tar -xzf Python-2.7.10.tgz

#make/install the file to configure python and check python version installed in container by using command [python2.7 -V]
RUN cd Python-2.7.10 && ./configure && make altinstall

############################ START Apache tomcat 7 INSTALLATION ##########################

#Install WGET
RUN yum install -y wget

#Install tar
RUN yum install -y tar

#Install Openjdk7
RUN yum update -y && \
yum install -y wget && \
yum install -y java-1.7.0-openjdk java-1.7.0-openjdk-devel && \
yum clean all

# Download Apache Tomcat 7
RUN cd /tmp;wget https://archive.apache.org/dist/tomcat/tomcat-7/v7.0.73/bin/apache-tomcat-7.0.73.tar.gz

# untar and move to proper location using gunzip , tar for extraction and mv for move to particular location
RUN cd /tmp;gunzip apache-tomcat-7.0.73.tar.gz
RUN cd /tmp;tar xvf apache-tomcat-7.0.73.tar
RUN cd /tmp;mv apache-tomcat-7.0.73 /opt/tomcat7

#providing executable permission through chmod
RUN chmod -R 755 /opt/tomcat7

#Start tomcat-7 using catalina.sh
CMD /opt/tomcat7/bin/catalina.sh run

#Opens a port for linked containers on 8080
EXPOSE 8080

############################ START Mongodb INSTALLATION ####################################

#Updating repo sources with clean up
RUN yum -y update; yum clean all

#Installing epel-release packages and libraries for centos
RUN yum -y install epel-release; yum clean all

#Installing mongo db server
RUN yum -y install mongodb-server; yum clean all

#Creating directory for mongodb db
RUN mkdir -p /data/db

#Opens a port for linked containers on 27017
EXPOSE 27017
#ENTRYPOINT ["/usr/bin/mongod"]