# vim: set expandtab ts=4 sw=4:

kinit() {
    if [[ $1 =~ "admin" ]]; then
        echo "(--no-f added)"
        /usr/bin/kinit --no-f $@
    else
        /usr/bin/kinit $@
    fi
}