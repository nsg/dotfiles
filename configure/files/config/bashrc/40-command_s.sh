# vim: set expandtab ts=4 sw=4:

__s__cache_all_hosts() {
    local out="$1"

    $HOME/code/*/*/hosts/inventory.py --list \
        | jq '.[].hosts' \
        | awk -F'"' '/"/{ print $2 }' \
        | sort \
        | uniq \
        > $out
}

__s__list_all_hosts() {

    local cache_path=/tmp/__s__list_all_hosts__cache
    local cache_age=86400

    if [ -f $cache_path ]; then
        local cache_age=$(( $(date +%s) - $(date -r $cache_path +%s) ))
    fi

    if [ $cache_age -gt 300 ]; then
        __s__cache_all_hosts $cache_path
    fi

    cat $cache_path
}

__s__grep() {
    grep -E "${1//\*/.*}"
}

__s__complete() {
    local word="${COMP_WORDS[COMP_CWORD]}";
    mapfile -t COMPREPLY < <(__s__list_all_hosts | __s__grep $word)
}

s() {
    /usr/bin/ssh $@
}

complete -F __s__complete s
