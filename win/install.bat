@echo off

echo cd  : "%cd%"
echo dir : "%~dp0"
echo file: "%~f0"

echo arg1: %1
echo.

if "%1" == "--install" (
	echo "install reg info.."
	REM reg add HKCU\Software\Classes\ssh\shell\open\command /ve  /t REG_SZ  /d "\"%cd%\ssh_url_parser.bat\" %%1" -f
	reg add HKCU\Software\Classes\ssh\shell\open\command /ve  /t REG_SZ  /d "\"%~dp0ssh_url_parser.bat\" %%1" -f
	REM reg add HKCU\Software\Classes\ssh\shell\open\command /ve  /t REG_SZ  /d "\"%~f0\" %%1" -f
	exit /b
)

reg query HKCU\Software\Classes\ssh\shell\open\command /ve
