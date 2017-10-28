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
    local number=$3

    local projects=(~/code/*${scope}*/*${project}*)
    if [ ${#projects[@]} -gt 1 ]; then
        if [ ! -z $number ] && [ $number -lt ${#projects[@]} ]; then
            cd ${projects[$number]}
        else
            for (( n=0; n<${#projects[@]}; n++ )); do
                echo "$n) ${projects[$n]}"
            done
        fi
    else
        cd ${projects[0]}
    fi
}

# Workaround for https://github.com/neovim/neovim/issues/6802
vim() {
    COLORTERM=gnome-terminal nvim $@
}
