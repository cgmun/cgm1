#!/bin/bash

# Do just enough to install git and ansible
# script does a git clone of cgm1 repo and run install.yml playbook.

export oldDir=$PWD
apt update
apt upgrade -y
apt autoremove -y
apt install software-properties-common -y
apt-add-repository ppa:ansible/ansiblei -y -u
apt install -y git ansible

repo=cgm1
git clone https://github.com/cgmun/$repo.git
cd $repo/setup
ansible-playbook install.yml

