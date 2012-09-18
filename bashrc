[ -z "$PS1" ] && return

##
# Settings
##
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTCONTROL=ignoreboth
export EDITOR=vim

shopt -s histappend
shopt -s checkwinsize

##
# Lesspipe
##

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

##
# Prompt
##

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

function left_prompt_command() {

    local yellow=$(tput setaf 3)

    if [ -f /usr/bin/klist ]; then
        /usr/bin/klist > /dev/null 2>&1
        if [ $? == 0 ]; then
            # awk code may cause problem i your principal is shorter
            # than 7 characters (id@hostname).
            echo -en "${yellow}$(klist | awk {'if(length($2)>7) {print $2}'} | awk -F @ '{print $1}') "
        fi
    fi

}

function right_prompt_command() {

    local yellow=$(tput setaf 3)
    local white=$(tput setaf 7)

    echo -en $yellow

    if [ -f /usr/bin/git ]; then
        /usr/bin/git status > /dev/null 2>&1
        if [ $? == 0 ]; then
            echo -en "($(git branch | grep \* | awk '{print $2}')"
            echo -en $yellow
            echo -en ") $(git config -l | grep remote.origin.url | awk -F : '{print $2}')"
        fi
    fi

    if [ -f /usr/bin/svn ]; then
        /usr/bin/svn info > /dev/null 2>&1
        if [ $? == 0 ]; then
            echo -n "r$(/usr/bin/svn info | grep Revision: | awk '{print $2}')"
        fi
    fi

    echo -en " $white[$1]"

}

function prompt_command() {
    local r_prompt="$(right_prompt_command $?)"
    r_prompt_plain="$(echo $r_prompt | sed -r 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g')"
    tput sc
    tput cuf $(expr $COLUMNS - ${#r_prompt_plain})
    echo -en $r_prompt
    tput rc
    left_prompt_command
}

PROMPT_COMMAND=prompt_command

##
# ls
##

if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

##
# Alias
##

alias ll='ls -l'
alias o='gnome-open'

##
# Completion
##

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

##
# Bash completions
##

function __rtl() {
    local cur list
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"

    if [[ $cur == -* ]]; then
        list="$(rtl --params)"
        COMPREPLY=( $(compgen -W "${list}" -- ${cur}) )
    else
        list="$(rtl --plain | awk -F '\t' '{print $2}' | head -15)"
        COMPREPLY=( $(compgen -W "${list}" -- ${cur}) )
    fi

    return 0
}

complete -F __rtl rtl

##
# Kerberos
##

function kinit() {
    if [[ $1 =~ "admin" ]]; then
        echo "(--no-f added)"
        /usr/bin/kinit --no-f $@
    else
        /usr/bin/kinit $@
    fi
}

##
# Kerberos
##

function krb() {
    local OPTIND
    local OPTARG
    local OPTNAME
    while getopts ":rac:s:dDhg" OPTNAME; do
        case $OPTNAME in
            r)
                KRB_TYPE=/root
                ;;
            a)
                KRB_TYPE=/admin
                ;;
            g)
                KRB_GLOBAL=true
                ;;
            c)

                # Select cell
                if [[ $OPTARG == nsg ]]; then
                    local cell=@STACKEN.KTH.SE
                elif [[ $OPTARG == stefan ]]; then
                    local cell=@SOUTHPOLE.SE
                fi

                # Local och global namespace
                if [[ -z $KRB_GLOBAL ]]; then
                    export KRB5CCNAME="/tmp/krb5cc_${cell/@/}_${KRB_TYPE/\//}"
                else
                    export KRB5CCNAME="/tmp/krb5cc_$UID"
                fi

                # Check for expired tickets
                klist | grep Expired -q
                if [ $? == 0 ]; then 
                    rm $KRB5CCNAME
                    echo "Expired credentials, old credentials removed."
                fi

                # Check out a ticket (if needed)
                if [ ! -f $KRB5CCNAME ]; then
                    kinit ${OPTARG}${KRB_TYPE}${cell}

                    if [ $? != 0 ]; then
                        rm $KRB5CCNAME
                        unset KRB5CCNAME
                    fi
                fi

                # Clean up
                unset KRB_TYPE
                unset KRB_GLOBAL
                ;;
            s)
                ssh -l root $OPTARG
                ;;
            D)
                rm -v $KRB5CCNAME
                unset KRB5CCNAME
                ;;
            d)
                unset KRB5CCNAME
                ;;
            h)
                echo "-c nsg       check out nsg@STACKEN.KTH.SE"
                echo "-rc stefan   check out stefan/root@SOUTHPOLE.SE"
                echo "-ac stefan   check out stefan/admin@SOUTHPOLE.SE"
                echo "-gc stefan   check out stefan@SOUTHPOLE.SE to global namespace"
                echo "-d           return to global namespace"
                echo "-D           return to global namespace AND destory ticket"
                ;;
            "?")
                echo "Unknown option $OPTARG"
                echo "Use -h for help"
                ;;
            ":")
                echo "No argument value for option $OPTARG"
                ;;
            *)
                echo "Error"
        esac
    done
}
