#!/bin/bash
#installing ssm agent
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_arm64/amazon-ssm-agent.rpm\
sudo systemctl status amazon-ssm-agent
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent


#commands for installing mysql
sudo yum update -y 
yum install -y mysql

#commands for installing mongo 4.22 version
sudo yum install libcurl openssl xz-libs
sudo wget https://fastdl.mongodb.org/linux/mongodb-linux-aarch64-amazon2-4.4.22.tgz
sudo tar -zxvf mongodb-linux-aarch64-amazon2-4.4.22.tgz
sudo cp mongodb-linux-aarch64-amazon2-4.4.22/bin/* /usr/bin/
sudo mkdir -p /var/lib/mongo
sudo mkdir -p /var/log/mongodb
sudo chown `whoami` /var/lib/mongo     
sudo chown `whoami` /var/log/mongodb
sudo mongod --dbpath /var/lib/mongo --logpath /var/log/mongodb/mongod.log --fork
