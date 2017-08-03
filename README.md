# cgm1
Testing Ansible, Nomad and Consul, Docker, LXD

Start by
curl https://raw.githubusercontent.com/cgmun/cgm1/master/setup/install.sh |bash

Property.yml 
---
hashi_mgmt_count: $hashi_mgmt_count"
hashi_node_count: $hashi_node_count"
CLC_V2_API_USERNAME: $CLC_V2_API_USERNAME"
CLC_V2_API_PASSWD: $CLC_V2_API_PASSWD"
ansible_user: $ansible_user"
ansible_ssh_pass: $ansible_ssh_pass"
...

if property.yml does not exist, then script will ask for info and create the property file.i
defaults: hashi_mgmt_count min 3 and hashi_node_count min 2.


