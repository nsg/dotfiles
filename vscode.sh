#!/bin/bash

set -euo pipefail

vscode_install_extension() {
    if ! code --list-extensions | grep -E "^$1\$" &> /dev/null; then
        code --install-extension "$1"
    fi
}

vscode_install_extension ms-vsliveshare.vsliveshare
vscode_install_extension redhat.vscode-yaml
vscode_install_extension ms-python.python
vscode_install_extension github.copilot
vscode_install_extension streetsidesoftware.code-spell-checker

mkdir -p ~/.config/Code/User
cp -v configure/files/vscode/settings.json \
    ~/.config/Code/User/settings.json