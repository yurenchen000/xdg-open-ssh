xdg-open web-links like `ssh://user:pass@host:port` on linux chrome/firefox


> inspired by this post  
>   https://soultrace.net/open-ssh-urls-in-chrome-and-firefox/
   

url scheme:

    ssh://[user[:pass]@]host[:port]


NOTICE: this simple script tool maybe has **command injection vulnerability**, only open links you trusted.

## linux
xdg-open-ssh:

use `gnome-terminal` or `terminator` open the ssh url,  
  if `pass` occur, use `sshpass` input password.  
     if `pass` err, failback to user input password.

install:

    install.sh

## windows
`win/ssh_url_handle.bat` for win `ssh://` url handle.

install:

    ssh_url_handle.bat --install

usage:  

edit `ssh_url_handle.bat` to add custom terminal application path.  
sercureCRT and putty as demo in script.

```bat
REM set "secureCRT=N:\d_soft_80\Program Files\SecureCRT\SecureCRT.exe"
set "putty=N:\d_soft_80\Program\putty\PUTTY.EXE"
```

<br>

## Other Bash Script

[![other bash repos](https://res.ez2.fun/svg/repos-bash_script.svg)](https://github.com/yurenchen000/yurenchen000/blob/main/repos.md#bash-scripts)


