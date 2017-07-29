#!/bin/bash

# Do just enough to install git and ansible
# script does a git clone of cgm1 repo and run install.yml playbook.

export oldDir=$PWD
echo "[CGM] apt update running" 
apt update
echo "[CGM] apt upgrade running"
yes '' | apt upgrade -y 
echo "[CGM] apt auto remove running"
apt autoremove -y
echo "[CGM] apt install  software-properties-common"
apt install software-properties-common -y
echo "[CGM] apt add repo"
apt-add-repository ppa:ansible/ansible -y -u
echo "[CGM] apt install ansibe"
apt install -y git ansible
echo "[CGM] git cgm1"
repo=cgm1
git clone https://github.com/cgmun/$repo.git
cd $repo/setup
pwd
echo "[CGM] galaxy install required ansible module"
ansible-galaxy install -r requirements.yml

echo "[CGM] run install.yml playbook"
ansible-playbook install.yml

cd ../
pwd
echo "[CGM] run site.yml playbook to build hasicorp cluster"
ansible-playbook bld_hashi_cluster.yml
