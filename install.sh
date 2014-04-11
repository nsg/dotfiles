#!/bin/bash

sudo apt-get install python-pip
sudo pip install ansible
export ANSIBLE_NOCOWS=1 # kill the cow!
ansible-playbook -c local -i localhost_inventory site.yml
