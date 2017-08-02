#!/bin/bash

# Do just enough to install git and ansible
# script does a git clone of cgm1 repo and run install.yml playbook.

export oldDir=$PWD
echo "[CGM] test passing variable"


ansible_user=root
ansible_ssh_pass=$1
CLC_V2_API_USERNAME=$2
CLC_V2_API_PASSWD=$3
mgnt_node=$4
client_node=$5
