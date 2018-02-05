# vim: set expandtab ts=4 sw=4:

rcsdifftool() {
    local file=$1
    local rev=$2

    if [ -z $file ] || [ -z $rev ]; then
        echo "rcsdifftool <file> <rev>"
        return 1
    fi

    if [ ! -f $file ]; then
        echo "File not found: $file"
        return 1
    fi

    local rev_part1="$(echo $rev | cut -d'.' -f1)"
    local rev_part2="$(echo $rev | cut -d'.' -f2)"
    local f="$rev_part1.$(( $rev_part2 - 1 ))"

    TMPFILE=$(mktemp)

    if type colordiff 2>&1 >/dev/null; then
        DIFF=colordiff
    else
        DIFF=diff
    fi

    co -p$f $file >> $TMPFILE
    co -p$rev $file | $DIFF -u $TMPFILE -
    rm $TMPFILE
}
