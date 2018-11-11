#!/bin/bash

sudo yum update –y
sudo yum -y install java-1.8.0
sudo yum -y install git
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install jenkins -y
sudo service jenkins start

sudo su - jenkins -c 'curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash'
sudo su -
export NVM_DIR="/root/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install 6.14.4

sudo yum -y install docker
sudo adduser dev
sudo usermod -a -G docker dev
