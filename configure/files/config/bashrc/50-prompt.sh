# vim: set expandtab ts=4 sw=4:

# VTE/Tilix integration for proper directory tracking
if [ "$TILIX_ID" ] || [ "$VTE_VERSION" ]; then
    source /etc/profile.d/vte*.sh 2>/dev/null
fi

# Load starship prompt (skip in VS Code terminal)
[[ "$TERM_PROGRAM" != "vscode" ]] && eval "$(starship init bash)"
