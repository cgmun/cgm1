#!/bin/bash

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


#apt-get install `cat listpackages.txt`
#pip install pip --upgrade 
#pip install -r ansible-server-requirements.txt


#git clone https://github.com/CenturyLinkCloud/clc-python-sdk.git
#cd clc-python-sdk/src
#pip install .
#cd $oldDir


#git clone https://github.com/CenturyLinkCloud/clc-ansible-module.git
#cd clc-ansible-module
#pip install -r requirements.txt
#cp clc-ansible-module/

# apt-get install $(grep -vE "^\s*#" filename  | tr "\n" " ")
# xargs -a <(awk '! /^ *(#|$)/' "$packagelist") -r -- sudo apt-get install


