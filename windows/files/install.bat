@echo off
rem install.bat
rem Author: Miguel Jimenez
rem Date  : July 10, 2017
rem 
rem This program installs CLion, and either Cygwin or MinGW.
rem Its main purpose is to facilitate the configuration of the
rem GNU environment required to compile and run C programs.
rem 
rem arguments: GNU environment provider (CYGWIN, MINGW)
rem 
title CSC 111 - CLion Installation
rem select the Cygwin installer according to the architecture
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0"^
    | find /i "x86" > NUL && (set ARCH=x86&& set ARCHNUM=32) || (set ARCH=x86_64&& set ARCHNUM=64)
set CYGWIN_VERSION=v2.8.1
set MINGW_VERSION=v7.1.0
set CLION_VERSION=v2017.2.1
set CLION_FILE=files\CLion-%CLION_VERSION%.exe
set CLION_URL=https://download-cf.jetbrains.com/cpp/CLion-2017.2.1.exe

if "%~1"=="CYGWIN" (
    set PROVIDER=Cygwin %CYGWIN_VERSION%
    set PROVIDER_ROOT=%SystemDrive%\cygwin
    set PROVIDER_FILE=files\cygwin.exe
    set PROVIDER_URL=https://cygwin.com/setup-%ARCH%.exe
) else if "%~1"=="MINGW" (
    set PROVIDER=MinGW %MINGW_VERSION%
    set PROVIDER_ROOT=%SystemDrive%\MinGW
    set PROVIDER_FILE=files\mingw.7z
    if %ARCH%==x86 (
        set PROVIDER_URL="https://sourceforge.net/projects/mingw-w64/files/Toolchains targetting Win32/Personal Builds/mingw-builds/7.1.0/threads-posix/dwarf/i686-7.1.0-release-posix-dwarf-rt_v5-rev1.7z/download"
    ) else (
        set PROVIDER_URL="https://sourceforge.net/projects/mingw-w64/files/Toolchains targetting Win64/Personal Builds/mingw-builds/7.1.0/threads-posix/seh/x86_64-7.1.0-release-posix-seh-rt_v5-rev1.7z/download"
    )
)

call :header
call :install_environment %~1
call :install_clion
call :footer
goto :EOF

rem procedure definitions

rem Print a friendly header
rem arguments: --
:header
echo ---------------------------------------------------------------
echo                   University of Victoria
echo                 Computer Science Department
echo ---------------------------------------------------------------
echo  Hello there fellow student! this program will assist you
echo  in the installation of:
echo    1. %PROVIDER%
echo    2. JetBrains CLion %CLION_VERSION%
echo ---------------------------------------------------------------
goto :EOF

rem Print a friendly footer
rem arguments: --
:footer
echo. 
echo  The installation is now complete. The command line utilities
echo  to compile and run C programs will be avaible after rebooting
echo  your computer.
echo. 
echo  You may now close this window and remove the files. Bye!
echo ---------------------------------------------------------------
goto :EOF

rem Install the GNU environment to compile and
rem run C programs
rem arguments: the selected environment (CYGWIN, MINGW)
:install_environment
echo  + Downloading %PROVIDER%
call :download "%PROVIDER%" %PROVIDER_URL% "%PROVIDER_FILE%"
if "%~1"=="CYGWIN" (
    echo  + Installing %PROVIDER%
    %PROVIDER_FILE% ^
        --wait --no-desktop --no-shortcuts --no-startmenu ^
        --quiet-mode --root %PROVIDER_ROOT% --site http://muug.ca/mirror/cygwin ^
        -P wget -P gcc-g++ -P make -P diffutils -P libmpfr-devel -P libgmp-devel ^
        -P libmpc-devel -P gdb > NUL
) else if "%~1"=="MINGW" (
    echo  + Extracting %PROVIDER%. This may take several minutes
    files\extra\7za-%ARCH%.exe x %PROVIDER_FILE% -y -o%SystemDrive%
    if exist "%PROVIDER_ROOT%\" rd /q /s %PROVIDER_ROOT%
    move %SystemDrive%\mingw%ARCHNUM% %PROVIDER_ROOT% > NUL
)
rem add executables to the PATH
echo  + Updating the PATH variable
cmd /c ""files\extra\pathmgr.bat" /add /y %PROVIDER_ROOT%\bin" > NUL
goto :EOF

rem Download and install CLion
rem arguments: --
:install_clion
echo  + Downloading CLion %CLION_VERSION%
call :download "CLion %CLION_VERSION%" "%CLION_URL%" "%CLION_FILE%"
echo  + Installing %CLION_VERSION%
%CLION_FILE% > NUL
goto :EOF

rem Downloads a given URL using wget
rem arguments: file name, URL, output file
:download
start "Downloading %~1 - DO NOT CLOSE THIS WINDOW" /WAIT^
    files\extra\curl.exe -k -L -C - %2 -o %3
goto :EOF
