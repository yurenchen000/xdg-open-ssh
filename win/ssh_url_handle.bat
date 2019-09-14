@echo off
REM ----------------------------------------
REM ssh_url_parser.bat            @yurenchen
REM 
REM arg format   ssh://root:pass@10.1.1.1:22
REM ----------------------------------------

REM ---------- setting

REM set "secureCRT=N:\d_soft_80\Program Files\SecureCRT\SecureCRT.exe"
set "putty=N:\d_soft_80\Program\putty\PUTTY.EXE"


REM ---------- install self
if "%1" == "--install" (
	echo "install reg info.."
	REM reg add HKCU\Software\Classes\ssh\shell\open\command /ve  /t REG_SZ  /d "\"%~dp0ssh_url_handle.bat\" %%1" -f
	reg add HKCU\Software\Classes\ssh\shell\open\command /ve  /t REG_SZ  /d "\"%~f0\" %%1" -f
	exit /b
)

REM ----------
set arg=%1
echo arg: %arg%

set url=%arg:*//=%
set url=%url:/=%
echo url: %url%


REM ---------- cmdline for SecureCRT 
set "SecureCRT_arg=ssh2://%url%"
IF NOT "%secureCRT%" == "" (
	echo --- secureCRT %SecureCRT_arg%
	start %secureCRT% %SecureCRT_arg%
	exit
)

set "a=%url:@=" & set "h=%"
REM echo a: %a%
REM echo h: %h%

set "user=%a::=" & set "pass=%"
echo user: %user%
echo pass: %pass%

set "host=%h::=" & set "port=%"
echo host: %host%
echo port: %port%

REM ---------- cmdline for Putty
IF NOT "%putty%" == "" (
	echo --- putty %user%@%host% -P %port% -pw %pass%
	START %putty% %user%@%host% -P %port% -pw %pass%
	exit
)

REM ---------- cmdline for ...


REM pause

REM ------------ String Split in Batch
REM https://stackoverflow.com/a/33131797
