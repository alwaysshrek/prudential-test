#!/bin/bash

sudo yum update –y
sudo yum -y install java-1.8.0
sudo yum -y install git
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install jenkins -y
sudo service jenkins start

sudo yum -y install docker
sudo adduser dev
sudo usermod -a -G docker dev
sudo usermod -a -G docker jenkins
