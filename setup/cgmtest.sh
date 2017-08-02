#!/bin/bash

# Do just enough to install git and ansible
# script does a git clone of cgm1 repo and run install.yml playbook.

export oldDir=$PWD
echo "[CGM] test passing variable"

mgnt_node=$1
client_node=$2

CLC_V2_API_USERNAME=$3
CLC_V2_API_PASSWD=$4

ansible_user=root
ansible_ssh_pass=$5
