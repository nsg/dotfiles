#!/bin/bash

message() {
	echo
	echo "$1"
	echo
}

message "Install packages needed by ansible"
sudo apt-get install python-pip
sudo pip install ansible

message "Run ansible playbook"
export ANSIBLE_NOCOWS=1 # kill the cow!
ansible-playbook -c local -s -K -i localhost_inventory site.yml
