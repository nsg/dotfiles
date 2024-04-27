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
# Gnome configuration
#
dconf write /org/gnome/desktop/wm/preferences/mouse-button-modifier "'<Alt>'"
dconf write /org/gnome/desktop/wm/preferences/focus-mode "'sloppy'"
