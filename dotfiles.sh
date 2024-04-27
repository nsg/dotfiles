#!/bin/bash

set -euo pipefail

mkdir -p ~/bin

#
# Configure bash
#
mkdir -p ~/.config/bashrc
cp -vr configure/files/config/bashrc/* ~/.config/bashrc
cp -v configure/files/bashrc ~/.bashrc
cp -v configure/files/inputrc ~/.inputrc

#
# Git
#
cp -v configure/files/gitignore ~/.gitignore
cp -v configure/files/gitconfig ~/.gitconfig