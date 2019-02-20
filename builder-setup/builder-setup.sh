#!/bin/bash
# Create .ssh folder if it doesn't exist.
[[ -d /home/ubuntu/.ssh ]] || mkdir /home/ubuntu/.ssh
# Copy pre-generated keys.
cp ssh-keys/* /home/ubuntu/.ssh/
sudo apt-get -y install software-properties-common
# Uncomment the following 3 lines when using Ubuntu 14.04, to get python-2.7.9
#wget https://gist.githubusercontent.com/drjerry/06041e0d78935e9d0b9e/raw/5af1922a92e2cd9eb2fb4e620191788ea2c66b67/build-python-2.7.9.sh
#sudo sh build-python-2.7.9.sh
# sudo apt-add-repository ppa:ansible/ansible-1.9
sudo apt-get -y update
sudo apt-get install -y python-pip libssl-dev
sudo pip install --upgrade pip
sudo pip install jinja2
sudo pip install ansible==1.9.4
