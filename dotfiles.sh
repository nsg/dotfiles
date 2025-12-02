#!/bin/bash

set -euo pipefail

install_starship() {
    local bin_dir="/usr/local/bin"
    local url="https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-musl.tar.gz"

    curl --fail --silent --location "$url" | tar -xzf - -O starship > tmp_starship
    sudo install -m 755 tmp_starship "${bin_dir}/starship"
    rm -f tmp_starship
}

mkdir -p ~/bin ~/.config

#
# Configure bash
#
command -v starship &> /dev/null || install_starship
cp -v configure/files/config/starship.toml ~/.config/starship.toml
cp -rv configure/files/config/bashrc ~/.config/
cp -v configure/files/inputrc ~/.inputrc
grep -q 'for f in ~/.config/bashrc' ~/.bashrc || echo 'for f in ~/.config/bashrc/*.sh; do source "$f"; done' >> ~/.bashrc

#
# Git
#
cp -v configure/files/gitignore ~/.gitignore
cp -v configure/files/gitconfig ~/.gitconfig
