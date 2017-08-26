# vim: set expandtab ts=4 sw=4:

if [ -x /usr/bin/lesspipe ]; then
    eval "$(SHELL=/bin/sh lesspipe)"
fi

if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

if hash xdg-open 2>&1 > /dev/null; then
    alias o='xdg-open'
else
    alias o='gnome-open'
fi

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

