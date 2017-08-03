#!/bin/bash

# Do just enough to install git and ansible
# script does a git clone of cgm1 repo and run install.yml playbook.

# Setup defaults
repo="cgm1"
prop_file="property.yml"
ansible_user="root"
hashi_mgmt_count=3
hashi_node_count=2


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
git clone https://github.com/cgmun/$repo.git
cd $repo/setup
pwd
echo "[CGM] galaxy install required ansible module"
ansible-galaxy install -r requirements.yml

echo "[CGM] run install.yml playbook"
ansible-playbook install.yml

# start  the cluster build out

askQuestions() {
  read -p "How many Management nodes?[min 3]  " mgmt_count
  if [[ $mgmt_count > 3 ]]; then  hashi_mgmt_count=$mgmt_count; fi
  read -p "How many Client nodes? [min 2]  " node_count
  if [[ $node_count > 2 ]]; then hashi_node_count=$node_count; fi
  read -p "CLC User Id  " CLC_V2_API_USERNAME
  if [[ -z "$CLC_V2_API_USERNAME" ]]; then echo "CLC user id can not emtpy."; exit 1; fi 
  read -p "CLC password  " CLC_V2_API_PASSWD
  if [[ -z "$CLC_V2_API_USERNAME" ]]; then echo "CLC password can not emtpy."; exit 1; fi  
  read -p "Server root password  " ansible_ssh_pass
  if [[ -z "$ansible_ssh_pass" ]]; then echo "Server root password can not emtpy."; exit 1; fi  
}

echoAnswers() {
  echo "hashi_mgmt_count=$hashi_mgmt_count"
  echo "hashi_node_count=$hashi_node_count"
  echo "CLC_V2_API_USERNAME=$CLC_V2_API_USERNAME"
  echo "CLC_V2_API_PASSWD=$CLC_V2_API_PASSWD"
  echo "ansible_user=$ansible_user"
  echo "ansible_ssh_pass=$ansible_ssh_pass"
}

createYamlFile () {
  echo "---" > $prop_file
  echo "hashi_mgmt_count: $hashi_mgmt_count" >> $prop_file
  echo "hashi_node_count: $hashi_node_count" >> $prop_file
  echo "CLC_V2_API_USERNAME: $CLC_V2_API_USERNAME" >> $prop_file
  echo "CLC_V2_API_PASSWD: $CLC_V2_API_PASSWD" >> $prop_file
  echo "ansible_user: $ansible_user" >> $prop_file
  echo "ansible_ssh_pass: $ansible_ssh_pass" >> $prop_file
  echo "..." >> $prop_file
}

cd ../
pwd

if [[ ! -e "../property.yml" ]]; then
  askQuestions
  echoAnswers
  createYamlFile
else
  cp ../property.yml .
fi

echo "[CGM] run site.yml playbook to build hasicorp cluster"
ansible-playbook bld_hashi_cluster.yml -e "@property.yml"
