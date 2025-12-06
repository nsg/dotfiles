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

#
# Tiling Shell configuration
#
dconf write /org/gnome/shell/extensions/tilingshell/active-screen-edges false
dconf write /org/gnome/shell/extensions/tilingshell/enable-blur-selected-tilepreview false
dconf write /org/gnome/shell/extensions/tilingshell/enable-blur-snap-assistant false
dconf write /org/gnome/shell/extensions/tilingshell/enable-move-keybindings false
dconf write /org/gnome/shell/extensions/tilingshell/enable-window-border false
dconf write /org/gnome/shell/extensions/tilingshell/inner-gaps "uint32 0"
dconf write /org/gnome/shell/extensions/tilingshell/outer-gaps "uint32 0"
dconf write /org/gnome/shell/extensions/tilingshell/layouts-json "'[{\"id\":\"11497885\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.2261574990106846,\"height\":1,\"groups\":[1]},{\"x\":0.2261574990106846,\"y\":0,\"width\":0.42105263157894735,\"height\":1,\"groups\":[2,1]},{\"x\":0.647210130589632,\"y\":0,\"width\":0.35278986941036816,\"height\":1,\"groups\":[2]}]},{\"id\":\"11574116\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.24990106846062524,\"height\":1,\"groups\":[2]},{\"x\":0.5,\"y\":0,\"width\":0.2500989315393748,\"height\":1,\"groups\":[3,1]},{\"x\":0.24990106846062524,\"y\":0,\"width\":0.25009893153937535,\"height\":1,\"groups\":[1,2]},{\"x\":0.7500989315393748,\"y\":0,\"width\":0.24990106846062482,\"height\":1,\"groups\":[3]}]}]'"
dconf write /org/gnome/shell/extensions/tilingshell/selected-layouts "[['11497885', 'Layout 1'], ['11497885', '11574116'], ['11497885', '11574116']]"
