#!/bin/bash

# .desktop
sed "s:~:$HOME:" ssh-handler.desktop > ~/.local/share/applications/ssh-handler.desktop

# .sh
mkdir -p ~/bin/
cp -p ssh-handler.sh ~/bin/

# mime
xdg-mime default ssh-handler.desktop x-scheme-handler/ssh

