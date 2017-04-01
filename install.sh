#!/bin/bash

message() {
	echo "$1"
}

get_my_path() {
	pushd $(dirname $0) > /dev/null
	pwd -P
	popd > /dev/null
}

install_package() {
	if ! dpkg -s $1 2>&1 > /dev/null; then
		sudo apt install $1
	fi
}

SCRIPTPATH="$(get_my_path)"

# Setup a virtualenv with Ansible, install it if needed and
# activate the environment.
if ! type virtualenv 1> /dev/null 2>&1; then
	message "virtualenv is missing, I will install it"
	sudo apt install python-virtualenv
fi

if [ ! -e "$SCRIPTPATH/.env" ]; then
	virtualenv "$SCRIPTPATH/.env"
fi

. $SCRIPTPATH/.env/bin/activate

# Ansible needs a few libs and gcc, so make sure that they are installed
install_package python-dev
install_package libssl-dev
install_package gcc

if [ ! -e "$SCRIPTPATH/.env/bin/ansible" ]; then
	message "Install ansible with pip"
	pip install ansible==2.2.2
fi

export ANSIBLE_NOCOWS=1 # kill the cow!
ansible-playbook -c local -s -K -i 127.0.0.1, --diff site.yml
