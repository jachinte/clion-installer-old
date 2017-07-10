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
:: select the Cygwin installer according to the architecture
REG Query "HKLM\Hardware\Description\System\CentralProcessor\0"^
    | find /i "x86" > NUL^
    && set CYGWIN_EXE=setup-x86.exe || set CYGWIN_EXE=setup-x86_64.exe
SET CYGWIN_ROOT=%SystemDrive%\cygwin
SET CYGWIN_VERSION=v2.8.1
SET CLION_URL=https://download-cf.jetbrains.com/cpp/CLion-2017.1.3.exe
SET CLION_VERSION=v2017.1.3

ECHO -----------------------------------------------------------
ECHO                 University of Victoria
ECHO               Computer Science Department
ECHO -----------------------------------------------------------
ECHO  Hello there fellow student! this program will assist you
ECHO  in the installation of:
ECHO    1. Cygwin %CYGWIN_VERSION%
ECHO    2. JetBrains CLion %CLION_VERSION%
ECHO -----------------------------------------------------------

ECHO  + Installing Cygwin %CYGWIN_VERSION%
ECHO      The following packages will be installed:
ECHO          - wget
ECHO          - gcc-g++
ECHO          - make
ECHO          - diffutils
ECHO          - libmpfr-devel
ECHO          - libgmp-devel
ECHO          - libmpc-devel
ECHO          - gdb
files\%CYGWIN_EXE%^
        --wait --no-desktop --no-shortcuts --no-startmenu^
        --quiet-mode --root %CYGWIN_ROOT% --site http://muug.ca/mirror/cygwin^
        -P wget -P gcc-g++ -P make -P diffutils -P libmpfr-devel -P libgmp-devel^
        -P libmpc-devel -P gdb > NUL

ECHO  + Downloading CLion %CLION_VERSION%
CALL :download "CLion %CLION_VERSION%" %CLION_URL% files\CLion-%CLION_VERSION%.exe

ECHO  + Installing %CLION_VERSION%
files\CLion-%CLION_VERSION%.exe > NUL

ECHO  The installation is now complete :)
ECHO  You may now close this window and remove the files. Bye!
ECHO -----------------------------------------------------------

GOTO :EOF

:: function definitions

:: Downloads a given URL using wget
:: Arguments: file name, URL, output file
:download
START "Downloading %~1 - DO NOT CLOSE THIS WINDOW" /WAIT^
    %CYGWIN_ROOT%\bin\wget.exe -c -O "%3" "%2"
GOTO :EOF
