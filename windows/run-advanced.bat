rem run-advanced.bat
rem Author: Miguel Jimenez
rem Date  : August 9, 2017
rem 
rem This program selects and runs the adequate
rem CLion+dependencies installer.
rem 
rem Arguments: --
rem 
@echo off

rem Select installer and execute it
set /p choice= "Would you like to use (1) Cygwin or (2) MinGW? "
if %choice%==1 (
	set PROVIDER="CYGWIN"
) else if %choice%==2 (
	set PROVIDER="MINGW"
) else (
	echo The option you typed in is not valid.
	echo This window will close in 5 seconds.
	timeout /T 5 /NOBREAK
)

cmd /k ""files\install.bat" %PROVIDER%"
