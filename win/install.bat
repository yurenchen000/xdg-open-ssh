@echo off

echo cd  : "%cd%"
echo dir : "%~dp0"
echo file: "%~f0"

REM reg add HKCU\Software\Classes\ssh\shell\open\command /ve  /t REG_SZ  /d "\"%cd%\ssh_url_parser.bat\" %%1" -f
reg add HKCU\Software\Classes\ssh\shell\open\command /ve  /t REG_SZ  /d "\"%~dp0ssh_url_parser.bat\" %%1" -f
REM reg add HKCU\Software\Classes\ssh\shell\open\command /ve  /t REG_SZ  /d "\"%~f0\" %%1" -f

reg query HKCU\Software\Classes\ssh\shell\open\command /ve
