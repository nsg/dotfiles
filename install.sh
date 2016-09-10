#!/bin/bash

message() {
	echo "$1"
}

if ! type pip; then
	message "Install python-pip and dev"
	sudo apt-get install python-pip python-dev libssl-dev
fi

if ! type ansible; then
	message "Install ansible with pip"
	sudo pip install ansible
fi

message "Run ansible playbook"
export ANSIBLE_NOCOWS=1 # kill the cow!
ansible-playbook -c local -s -K -i 127.0.0.1, --diff site.yml
