# vim: set expandtab ts=4 sw=4:

sshnk() {
    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $@
}

kinit() {
    if [[ $1 =~ "admin" ]]; then
        echo "(--no-f added)"
        /usr/bin/kinit --no-f $@
    else
        /usr/bin/kinit $@
    fi
}

c() {
    local scope=$1
    local project=$2

    cd ~/code/*${scope}*/*${project}*
}

# Workaround for https://github.com/neovim/neovim/issues/6802
vim() {
    COLORTERM=gnome-terminal nvim $@
}
