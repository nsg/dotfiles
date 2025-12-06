#!/bin/bash

set -euo pipefail

install_package() {
	if ! dpkg -s $1 2>&1 > /dev/null; then
		sudo apt-get -y install $1
	fi
}

install_snap_package() {
    if ! snap list $1 2>&1 > /dev/null; then
        sudo snap install $1
    fi
}

install_classic_snap_package() {
    if ! snap list $1 2>&1 > /dev/null; then
        sudo snap install --classic $1
    fi
}

add_user_to_group() {
    if ! id --groups --name $1 | tr ' ' '\n' | grep -q $2; then
        sudo usermod -aG $2 $1
    fi
}

install_gh_release() {
    local repo="$1"
    local version="$2"
    local file="$3"
    local dest="$4"

    mkdir -p "$dest"
    curl -sL "https://github.com/$repo/releases/download/$version/$file" | \
        case "$file" in
            *.tar.gz|*.tgz) tar -xzf - -C "$dest" --strip-components=1 ;;
            *.tar.xz) tar -xJf - -C "$dest" --strip-components=1 ;;
            *.zip) funzip | tar -xf - -C "$dest" ;;
        esac
}

install_package neovim
install_package curl
install_package tig
install_package make
install_package tree
install_package whois
install_package mpv
install_package tilix
install_package dconf-editor
install_package hub
install_package gh
install_package flatpak
install_package gnome-software-plugin-flatpak
install_package jq
install_package podman
install_package nvme-cli
install_package python3-virtualenv
install_package distrobox
install_package lm-sensors
install_package htop

install_classic_snap_package snapcraft
install_classic_snap_package code
install_snap_package chromium
install_snap_package thunderbird
install_snap_package spotify

install_gh_release astral-sh/uv 0.9.15 uv-x86_64-unknown-linux-gnu.tar.gz "$HOME/bin"

flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install --user -y flathub com.mattjakeman.ExtensionManager

if zfs list | grep -q rpool/data; then
    #
    # Install and configure Incus
    #
    install_package incus
    add_user_to_group $USER incus
    if ! zfs list | grep -q rpool/data/incus; then
        sudo incus admin init --auto --storage-backend zfs --storage-pool rpool/data/incus
    fi

    #
    # Install and configure LXD
    #
    install_snap_package lxd
    add_user_to_group $USER lxd
    if ! zfs list | grep -q rpool/data/lxd; then
        sudo lxd init --auto --storage-backend zfs --storage-pool rpool/data/lxd
    fi
fi
