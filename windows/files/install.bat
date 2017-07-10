:: install.bat
:: Author: Miguel Jimenez
:: Date  : July 10, 2017
::
:: This program installs Cygwin and CLion. Its main
:: purpose is to facilitate the configuration of the
:: Cygwin packages required to compile and run C programs.
::
@ECHO off
TITLE CSC 111 - CLion Installation
SET CYGWIN_ROOT=%SystemDrive%\cygwin
SET CLION_URL=https://download-cf.jetbrains.com/cpp/CLion-2017.1.3.exe

ECHO -----------------------------------------------------------
ECHO                 University of Victoria
ECHO               Computer Science Department
ECHO -----------------------------------------------------------
ECHO  Hello there fellow student! this program will assist you
ECHO  in the installation of:
ECHO    1. Cygwin v2.8.1, released on June 23, 2016
ECHO    2. JetBrains CLion v2017.1.3, released on June 7, 2017
ECHO -----------------------------------------------------------
:: run functions
CALL :install_cygwin
CALL :download "CLion v2017.1.3" %CLION_URL% files\CLion-2017.1.3.exe
CALL :install_clion
ECHO  The installation is now complete :)
ECHO  You may now close this window and remove the files. Bye!
ECHO -----------------------------------------------------------

GOTO :EOF

:: function definitions

:: Executes the appropriate Cygwin installer
:: Arguments: --
:install_cygwin
ECHO  + Installing Cygwin v2.8.1
ECHO      The following packages will be installed:
ECHO          - wget
ECHO          - gcc-g++
ECHO          - make
ECHO          - diffutils
ECHO          - libmpfr-devel
ECHO          - libgmp-devel
ECHO          - libmpc-devel
ECHO          - gdb
:: select the installer according to the architecture
REG Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL^
    && set CYGWIN_EXE=setup-x86.exe || set CYGWIN_EXE=setup-x86_64.exe
:: launch Cygwin installer in quiet mode selecting the required packages only.
:: a Canadian mirror is used by default. Remove argument "site" if mirror is down
files\%CYGWIN_EXE%^
    --wait --no-desktop --no-shortcuts --no-startmenu --quiet-mode --root %CYGWIN_ROOT%^
    --site http://muug.ca/mirror/cygwin^
    -P wget -P gcc-g++ -P make -P diffutils -P libmpfr-devel -P libgmp-devel -P libmpc-devel -P gdb > NUL
GOTO :EOF

:: Executes the Clion installer
:: Arguments: --
:install_clion
ECHO  + Installing v2017.1.3
files\CLion-2017.1.3.exe > NUL
GOTO :EOF

:: Downloads a given URL using wget
:: Arguments: file name, URL, output folder
:download
ECHO  + Downloading %~1
START "Downloading %~1 - DO NOT CLOSE THIS WINDOW" /WAIT %CYGWIN_ROOT%\bin\wget.exe -c -O "%3" "%2"
GOTO :EOF
