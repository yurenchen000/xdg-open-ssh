#!/bin/bash

# inspired by this post
#   https://soultrace.net/open-ssh-urls-in-chrome-and-firefox/

#d=${1#ssh://}
#gnome-terminal -e "ssh $d" &  ## -e is deprecated
#gnome-terminal -- ssh "$d" &
#terminator -e "ssh $d" &


# xdg-open ssh://user:pass@host:port
parseURL(){
	[ "$1" == "-i" ] && flg_cur=1 && shift 1
	local s=${1##ssh://}
	local a=${s%%@*}
	[ "$a" == "$s" ] && a=''
	local h=${s##*@}

	local user=${a%%:*}
	local pass=${a##*:}
	[ "$pass" == "$a" ] && pass=''
	local host=${h%%:*}
	local port=${h##*:}
	port=${port%%/}
	[ "$port" == "$h" ] && port=''

	decodeURIComponent(){
		echo "$1" | sed -e 's/%\([0-9A-Fa-f][0-9A-Fa-f]\)/\\\x\1/g'  | xargs -0 printf "%b";
	}

	pass=`decodeURIComponent "$pass"`

	local cmd="$host"
	[ -n "$user" ] && cmd="$user@$cmd"
	[ -n "$port" ] && cmd="$cmd -p $port"
	cmd="ssh $cmd"
	cmd="$cmd -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
	#[ -n "$pass" ] && cmd="sshpass -p '$pass' $cmd"
	#[ -n "$pass" ] && cmd="sshpass -p '$pass' $cmd; [ \$? == 5 ] && echo login fail && $cmd"
	[ -n "$pass" ] && cmd="bash -c \"TERM=xterm-color sshpass -p '$pass' $cmd; [ \\\$? == 5 ] && echo 'incorrect password' && $cmd\""

	echo "url: $1"
	echo "cmd: $cmd"
	echo
	[ -n "$flg_cur" ] && { eval "$cmd"; return; }
	#$cmd

	#terminator -e "$cmd" &
	#gnome-terminal -e "$cmd"
	gnome-terminal -- $cmd
	#echo "ret: $?"
}

## test
# parseURL 'ssh://host'
# parseURL 'ssh://host:port'
# parseURL 'ssh://aaa@host:port'
# parseURL 'ssh://aaa:123@host:port'
# parseURL 'ssh://aaa:%25aa%25bb!%40%23%24%25%5E%26*()%3F%20%20%5C%2F@host:port'
# parseURL 'ssh://chen:abc@10.1.1.30:1234'

parseURL "$@"


