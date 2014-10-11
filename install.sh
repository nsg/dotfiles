#!/bin/bash

message() {
	echo "$1"
}

if ! type pip; then
	message "Install python-pip"
	sudo apt-get install python-pip
fi

if ! type ansible; then
	message "Install ansible"
	sudo pip install ansible
fi

message "Run ansible playbook"
export ANSIBLE_NOCOWS=1 # kill the cow!
ansible-playbook -c local -s -K -i 127.0.0.1, ansible/site.yml
