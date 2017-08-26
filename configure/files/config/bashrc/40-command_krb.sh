# vim: set expandtab ts=4 sw=4:

krb() {
    local OPTIND
    local OPTARG
    local OPTNAME
    while getopts ":radDhgGlv" OPTNAME; do
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
            G)
                cp $KRB5CCNAME /tmp/krb5cc_$krb5cc_$UID
                echo "Principal moved to global namespace"
                return 0
                ;;
            D)
                rm -v $KRB5CCNAME
                unset KRB5CCNAME
                return 0 # no more action
                ;;
            d)
                unset KRB5CCNAME
                return 0 # no more action
                ;;
            l)
                for t in $(ls -1 /tmp/krb5cc_*); do
                    KRB5CCNAME=$t klist -t
                    if [ $? == 0 ]; then
                        echo -n "[Valid]   "
                    else
                        echo -n "[Expired] "
                    fi
                    if [ "$KRB5CCNAME" == "$t" ] || [ "/tmp/krb5cc_${UID}${KRB5CCNAME}" == "$t" ]; then
                        echo -n "* "
                    else
                        echo -n "  "
                    fi
                    echo -n $t" ("
                    KRB5CCNAME=$t klist | grep Principal: | awk '{print $NF")"}'
                done
                return 0 # no more action
                ;;
            v)
                if [ -f $KRB5CCNAME ]; then
                    klist -t
                    if [ $? == 0 ]; then
                        klist | grep Principal: | awk '{print $NF}' | awk -F@ '{print $1}'
                    fi
                fi
                return 0 # no more action
                ;;
            h)
                echo "nsg          check out nsg@STACKEN.KTH.SE"
                echo "-r stefan    check out stefan/root@SOUTHPOLE.SE"
                echo "-a stefan    check out stefan/admin@SOUTHPOLE.SE"
                echo "-g stefan    check out stefan@SOUTHPOLE.SE to global namespace"
                echo "-d           return to global namespace"
                echo "-D           return to global namespace AND destory ticket"
                echo "-l           list principals"
                echo "-v           Current principal (short form)."
                return 0 # no more action
                ;;
            "?")
                echo "Unknown option $OPTARG"
                echo "Use -h for help"
                return 1 # no more action
                ;;
            ":")
                echo "No argument value for option $OPTARG"
                return 1 # no more action
                ;;
            *)
                echo "Error"
                return 2 # no more action
        esac
    done

    # Remove opts from input
    shift $((OPTIND-1))

    # Select cell
    if [[ $1 == nsg ]]; then
        local cell=@STACKEN.KTH.SE
    elif [[ $1 == stefan ]]; then
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
        kinit ${1}${KRB_TYPE}${cell}

        if [ $? != 0 ]; then
            rm $KRB5CCNAME
            unset KRB5CCNAME
        fi
    fi

    # Clean up
    unset KRB_TYPE
    unset KRB_GLOBAL

}

