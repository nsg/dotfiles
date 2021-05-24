# vim: set expandtab ts=4 sw=4:

export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTCONTROL=ignoreboth
export EDITOR=vim
export ANSIBLE_A_USER=stbe02
export PATH="~/bin:$PATH"
export GIT_CEILING_DIRECTORIES=/afs/stacken.kth.se

# Build KUBECONFIG
KUBECONFIG=""
for k in $HOME/.kube/*; do
    if [[ $k == *.yaml ]] || [[ $k == *.yml ]]; then
        KUBECONFIG="$k:$KUBECONFIG"
    fi
done
KUBECONFIG="${KUBECONFIG:0:-1}"
export KUBECONFIG
