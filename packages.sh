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
install_package flatpak
install_package gnome-software-plugin-flatpak
install_package jq
install_package podman
install_package nvme-cli
install_package python3-virtualenv
install_package distrobox

install_classic_snap_package snapcraft
install_classic_snap_package code
install_snap_package chromium

flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

