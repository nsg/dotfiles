# vim: set expandtab ts=4 sw=4:

# Clean up the prompt, this is not a complete solution but I know
# what control seq I use so that makes things simpler.
plain() {
    # sed 1: Remove __vte_osc7 control chars
    # sed 2: Remove color ^[[33m
    # sed 3: Remove color \[\033[01;34m\]
    # sed 4: Remove start/end of non visible chars
    cat -v - \
        | sed -r 's/\^.*\^G//g' \
        | sed -r 's/\^\[\[([0-9]+;)?[0-9]+m//g' \
        | sed -r 's/\033\[([0-9]{1,2}(;[0-9]{1,2})?)?m//g' \
        | sed -r 's/\^(A|B)//g'
}

# Prints the size of a string
size_of_str() {
    local str=$(cat -)
    echo ${#str}
}

# Nice coloured status logs
color_log() {
    local state=$1; shift
    local message="$@"

    case $state in
        info)
            echo -ne "\e[1m[INFO] "
            ;;
        warn)
            echo -ne "\e[33m[WARN] "
            ;;
        crit)
            echo -ne "\e[191m[CRIT] "
            ;;
    esac
    echo -ne "\e[21m"
    echo $message
}

