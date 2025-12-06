#!/bin/bash

set -euo pipefail

#
# Tilix configuration
#
dconf write /com/gexperts/Tilix/copy-on-select true
dconf write /com/gexperts/Tilix/auto-hide-mouse true
dconf write /com/gexperts/Tilix/theme-variant "'dark'"
dconf write /com/gexperts/Tilix/window-style "'normal'"
dconf write /com/gexperts/Tilix/keybindings/session-add-down "'<Primary><Shift>o'"
dconf write /com/gexperts/Tilix/keybindings/session-add-right "'<Primary><Shift>e'"
dconf write /com/gexperts/Tilix/keybindings/session-open "'disabled'"

#
# Disable emoji hotkey
#
dconf write /desktop/ibus/panel/emoji/hotkey "@as []"

#
# Gnome appearance
#
dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
dconf write /org/gnome/desktop/interface/gtk-theme "'Yaru-dark'"

#
# Gnome window management
#
dconf write /org/gnome/desktop/wm/preferences/mouse-button-modifier "'<Alt>'"
dconf write /org/gnome/desktop/wm/preferences/focus-mode "'sloppy'"

#
# Desktop Icons (DING extension)
#
dconf write /org/gnome/shell/extensions/ding/show-home false
dconf write /org/gnome/shell/extensions/ding/show-trash false
dconf write /org/gnome/shell/extensions/ding/show-volumes false

#
# Dash to Dock
#
dconf write /org/gnome/shell/extensions/dash-to-dock/dock-fixed false
dconf write /org/gnome/shell/extensions/dash-to-dock/dash-max-icon-size 38

#
# Tiling Assistant (Ubuntu default)
#
dconf write /org/gnome/shell/extensions/tiling-assistant/enable-tiling-popup false

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
dconf write /org/gnome/shell/extensions/tilingshell/layouts-json "'[{\"id\":\"11497885\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.2224609375,\"height\":1,\"groups\":[1]},{\"x\":0.2224609375,\"y\":0,\"width\":0.4517578124999999,\"height\":1,\"groups\":[2,1]},{\"x\":0.67421875,\"y\":0,\"width\":0.32578125000000013,\"height\":1,\"groups\":[2]}]},{\"id\":\"11574116\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.24990106846062524,\"height\":1,\"groups\":[2]},{\"x\":0.5,\"y\":0,\"width\":0.2500989315393748,\"height\":1,\"groups\":[3,1]},{\"x\":0.24990106846062524,\"y\":0,\"width\":0.25009893153937535,\"height\":1,\"groups\":[1,2]},{\"x\":0.7500989315393748,\"y\":0,\"width\":0.24990106846062482,\"height\":1,\"groups\":[3]}]}]'"
dconf write /org/gnome/shell/extensions/tilingshell/selected-layouts "[['11497885', 'Layout 1'], ['11497885', '11574116'], ['11497885', '11574116']]"
