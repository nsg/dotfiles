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
vscode_install_extension ms-python.vscode-pylance
vscode_install_extension streetsidesoftware.code-spell-checker
vscode_install_extension tamasfe.even-better-toml
vscode_install_extension ms-vscode.makefile-tools

# AI related extensions
vscode_install_extension ms-vscode.vscode-speech
vscode_install_extension github.copilot
vscode_install_extension github.copilot-chat

mkdir -p ~/.config/Code/User
cp -v configure/files/vscode/settings.json \
    ~/.config/Code/User/settings.json
