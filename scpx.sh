#!/bin/bash

## orig scp  support scp://[user@]host[:port][/path]
## this scpx support scp://[user:[pass]@]host[:port][/path]

print_var(){
    :
    # echo $'\e[35m'"== $@"$'\e[0m'
}

singlequote(){ echo "'${1//\'/\'\\\'\'}'"; }

scpx() {
    local arg1="$1"
    local arg2="$2"
    local url dest

    if [[ "$arg1" == ssh://* ]]; then
        url="$arg1"
        dest="$arg2"
    elif [[ "$arg2" == ssh://* ]]; then
        url="$arg2"
        dest="$arg1"
    else
        echo "Usage: scpx <local> <ssh-url> or scpx <ssh-url> <local>"
        return 1
    fi

    local s=${url##ssh://}
    local a=${s%%@*}  ## account
    [ "$a" == "$s" ] && a=''
    local h=${s##*@}  ## hostport

    local user=${a%%:*}
    local pass=${a##*:}
    [ "$pass" == "$a" ] && pass=''
    print_var "==h: $h"
    local host=${h%%:*}
    local port=${h##*:}
    print_var "host: $host"
    
    port=${port%%/*}
    print_var "port: $port"
    [ "$port" == "$h" ] && port=''

    decodeURIComponent() {
        echo "$1" | sed -e 's/%\([0-9A-Fa-f][0-9A-Fa-f]\)/\\\x\1/g' | xargs -0 printf "%b"
    }

    pass=$(decodeURIComponent "$pass")

    local scp_cmd="scp"
    [ -n "$port" ] && scp_cmd="$scp_cmd -P '$port'"
    # [ -n "$pass" ] && scp_cmd="sshpass -p '$pass' $scp_cmd" ## scp lose progress
    [ -n "$pass" ] && scp_cmd="SSHPASS='$pass' $scp_cmd -S ssh.sh " ## fix scp progress
    local remote="$host"
    [ -n "$user" ] && remote="$user@$remote"

    # Extract remote path
    local path="/"
    if [[ "$h" == *"/"* ]]; then
        path="/${h#*/}"
        host=${host%%/*}
        remote="$host"
        [ -n "$user" ] && remote="$user@$remote"
    fi
    print_var "path: $path"
    print_var "remote: $remote"

    # Determine direction
    if [[ "$arg1" == ssh://* ]]; then
        # remote to local
        scp_cmd="$scp_cmd '$remote:$path' '$dest'"

    else
        # local to remote
        scp_cmd="$scp_cmd '$dest' '$remote:$path'"
    fi

    echo $'\e[32m'"== $scp_cmd"$'\e[0m'
    eval "$scp_cmd"
}


"$@"

