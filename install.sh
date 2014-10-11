#!/bin/bash

message() {
	echo
	echo "$1"
	echo
}

if ! type pip; then
	message "Install packages needed by ansible"
	sudo apt-get install python-pip
	sudo pip install ansible
fi

message "Run ansible playbook"
export ANSIBLE_NOCOWS=1 # kill the cow!
ansible-playbook -c local -s -K -i 127.0.0.1, site.yml
