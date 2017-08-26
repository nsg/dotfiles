# vim: set expandtab ts=4 sw=4:

if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
else
    color_prompt=
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h \[\033[01;34m\]\W \$ \[\033[00m\]'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt

case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

# https://github.com/gnunn1/tilix/wiki/VTE-Configuration-Issue
# The function is called from post_prompt
if [[ $TILIX_ID ]] || [[ $TERMINIX_ID ]]; then
    if [ -e /etc/profile.d/vte.sh ]; then
        . /etc/profile.d/vte.sh
    elif [ -e /etc/profile.d/vte-*.sh ]; then
        . /etc/profile.d/vte-*.sh
    fi
fi

pre_prompt() {

    local yellow="\[$(tput setaf 3)\]"

    if [ -f /usr/bin/klist ]; then
        /usr/bin/klist > /dev/null 2>&1
        if [ $? == 0 ]; then
            echo -en "${yellow}$(krb -v) "
        fi
    fi

}

post_prompt() {
    local ret=$1
    local compact=$2

    local yellow=$(tput setaf 3)
    local white=$(tput setaf 7)

    # Output control chars for VTE terminals
    declare -f __vte_osc7 > /dev/null && __vte_osc7

    echo -en $yellow

    if [ -f /usr/bin/git ]; then
        if [ -d .git ] || [ git rev-parse --git-dir 2> /dev/null ]; then
            echo -en "($(git branch | grep \* | awk '{print $2}')"
            echo -en "$yellow)"
            if ! [ $compact ]; then
                echo -en " $(git config -l | grep remote.origin.url | awk -F : '{print $2}')"
            fi
        fi
    fi

    echo -en "$white"
    [ $ret != 0 ] && echo -n " r:$ret"
    [ -n "$(jobs)" ] && echo -n " j:\j"


}

set_prompt() {
    if [ -z "$PS1_ORIG" ]; then
        PS1_ORIG=$PS1
    fi

    # Build the right and left side prompt
    local r_prompt="$(post_prompt $?)"
    local l_prompt="$(pre_prompt)${PS1_ORIG}"

    # Calculate the visible size, @P is a bash 4.4 feature that expands the prompt
    local r_prompt_size="$(echo ${r_prompt@P} | plain | size_of_str)"
    local l_prompt_size="$(echo ${l_prompt@P} | plain | size_of_str)"

    if [ $(($COLUMNS - $l_prompt_size)) -le $r_prompt_size ]; then
        # The available space is to small, try with compact prompt
        r_prompt="$(post_prompt $? compact)"
        r_prompt_size="$(echo ${r_prompt@P} | plain | size_of_str)"
    fi

    if [ $(($COLUMNS - $l_prompt_size)) -le $r_prompt_size ]; then
        # Still no room left for right size prompt, disable it
        r_prompt=""
        r_prompt_move=0
    else
        # Calculate right prompt offset
        r_prompt_move=$(($COLUMNS - $r_prompt_size))
    fi

    # Build prompt
    PS1="${l_prompt}"                     # Print left side prompt
    PS1="${PS1}\[\033[s"                  # Save cursor position
    PS1="${PS1}\033[0;${r_prompt_move}H"  # Move cursor to top right corner
    PS1="${PS1}${r_prompt}"               # Print right prompt
    PS1="${PS1}\033[u\]"                  # Return to saved position
}

prompt_command() {
    set_prompt
}

PROMPT_COMMAND=prompt_command
