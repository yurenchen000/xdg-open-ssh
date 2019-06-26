xdg-open web-links like `ssh://user:pass@host:port` on linux chrome/firefox


> inspired by this post  
>   https://soultrace.net/open-ssh-urls-in-chrome-and-firefox/
   

url scheme:

    ssh://[user[:pass]@]host[:port]


xdg-open-ssh:

use `gnome-terminal` or `terminator` open the ssh url,  
  if `pass` occur, use `sshpass` input password.  
     if `pass` err, failback to user input password.

install:

    install.sh



