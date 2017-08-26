# vim: set expandtab ts=4 sw=4:

a() {
    local playbook="$1"; shift
    local git_root="$(git rev-parse --show-toplevel)"
    local inventory_path="$(find $git_root -name inventory.py | sort | tail -1)"

    if [ ! -e "$playbook" ]; then
        playbook=$(echo ${git_root}/playbooks/*${playbook}*/site.yml)
        color_log info "Expanded playbook to $playbook"
    else
        playbook="${PWD}/$playbook"
    fi
    pushd $git_root > /dev/null

    if [ ! -f "$playbook" ]; then
        color_log crit "Failed: $playbook not found"
    else

        ansible_version=$(awk '/ansible:/{print $NF}' $playbook)
        if [ -z "$ansible_version" ]; then
            color_log warn "No ansible version found, use system default"
        else
            if [ ! -e "${git_root}/.envs/$ansible_version" ]; then
                virtualenv "${git_root}/.envs/$ansible_version"
            fi
            . ${git_root}/.envs/$ansible_version/bin/activate
            if [ ! -e ${git_root}/.envs/$ansible_version/bin/ansible ]; then
                pip install "ansible==$ansible_version"
            fi
        fi

        if [ -e requirements.txt ]; then
            color_log info "Install the repos requirements.txt"
            pip install -r requirements.txt
        fi

        playbook_path="$(dirname $playbook)"
        if [ -e $playbook_path/requirements.txt ]; then
            color_log info "Install the playbooks requirements.txt"
            pip install -r $playbook_path/requirements.txt
        fi

        if [ -e $playbook_path/requirements.yml ]; then
            if [ -e $git_root/ansible-galaxy-version ]; then
                galaxy_binary="$git_root/ansible-galaxy-version"
            else
                galaxy_binary=ansible-galaxy
            fi

            color_log info "Install Ansible deps with $galaxy_binary"
            $galaxy_binary install -p $playbook_path/roles -r $playbook_path/requirements.yml
        fi

        ansible_cmd="ansible-playbook -i ${inventory_path} -u $ANSIBLE_A_USER -s $playbook $@"
        color_log info $ansible_cmd
        $ansible_cmd
    fi

    popd > /dev/null
}

