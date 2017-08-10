:: run.bat
:: Author: Miguel Jimenez
:: Date  : August 9, 2017
::
:: This program selects and runs the adequate
:: CLion+dependencies installer.
::
:: Arguments: --
::
@ECHO off

:: Select installer and execute it
SET /p choice= "Would you like to use (1) Cygwin or (2) MinGW? "
IF %choice%==1 (
	SET PROVIDER="CYGWIN"
) ELSE IF %choice%==2 (
	SET PROVIDER="MINGW"
) ELSE (
	ECHO The option you typed in is not valid.
	ECHO This window will close in 5 seconds.
	TIMEOUT /T 5 /NOBREAK
)

CMD /k ""files\install.bat" %PROVIDER%"
