#!/bin/bash

set -euo pipefail

install_gnome_extension() {
    local uuid="$1"
    
    # Check if already installed
    if gnome-extensions list | grep -qF "$uuid"; then
        gnome-extensions enable "$uuid" 2>/dev/null || true
        return
    fi

    # Install via D-Bus (same method as browser integration)
    gdbus call --session \
        --dest org.gnome.Shell.Extensions \
        --object-path /org/gnome/Shell/Extensions \
        --method org.gnome.Shell.Extensions.InstallRemoteExtension \
        "$uuid"

    gnome-extensions enable "$uuid" 2>/dev/null || true
}

install_gnome_extension "tilingshell@ferrarodomenico.com"
