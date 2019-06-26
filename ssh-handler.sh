#!/bin/bash

# inspired by this post
#   https://soultrace.net/open-ssh-urls-in-chrome-and-firefox/

#d=${1#ssh://}
#gnome-terminal -e "ssh $d" &
terminator -e "ssh $d" &




