:: install.bat
:: Author: Miguel Jimenez
:: Date  : July 10, 2017
::
:: This program installs CLion, and either Cygwin or MinGW.
:: Its main purpose is to facilitate the configuration of the
:: GNU environment required to compile and run C programs.
::
:: Arguments: GNU environment provider (CYGWIN, MINGW)
::
@ECHO off
TITLE CSC 111 - CLion Installation
:: select the Cygwin installer according to the architecture
REG Query "HKLM\Hardware\Description\System\CentralProcessor\0"^
    | FIND /i "x86" > NUL && (SET ARCH=x86&& SET ARCHNUM=32) || (SET ARCH=x86_64&& SET ARCHNUM=64)
SET CYGWIN_VERSION=v2.8.1
SET MINGW_VERSION=v7.1.0
SET CLION_VERSION=v2017.2.1
SET CLION_FILE=files\CLion-%CLION_VERSION%.exe
SET CLION_URL=https://download-cf.jetbrains.com/cpp/CLion-2017.2.1.exe

IF "%~1"=="CYGWIN" (
    SET PROVIDER=Cygwin %CYGWIN_VERSION%
    SET PROVIDER_ROOT=%SystemDrive%\cygwin
    SET PROVIDER_FILE=files\cygwin.exe
    SET PROVIDER_URL=https://cygwin.com/setup-%ARCH%.exe
) ELSE IF "%~1"=="MINGW" (
    SET PROVIDER=MinGW %MINGW_VERSION%
    SET PROVIDER_ROOT=%SystemDrive%\MinGW
    SET PROVIDER_FILE=files\mingw.7z
    IF %ARCH%==x86 (
        SET PROVIDER_URL="https://sourceforge.net/projects/mingw-w64/files/Toolchains targetting Win32/Personal Builds/mingw-builds/7.1.0/threads-posix/dwarf/i686-7.1.0-release-posix-dwarf-rt_v5-rev1.7z/download"
    ) ELSE (
        SET PROVIDER_URL="https://sourceforge.net/projects/mingw-w64/files/Toolchains targetting Win64/Personal Builds/mingw-builds/7.1.0/threads-posix/seh/x86_64-7.1.0-release-posix-seh-rt_v5-rev1.7z/download"
    )
)

CALL :header
CALL :install_environment %~1
CALL :install_clion
CALL :footer
GOTO :EOF

:: procedure definitions

:: Print a friendly header
:: Arguments: --
:header
ECHO ---------------------------------------------------------------
ECHO                   University of Victoria
ECHO                 Computer Science Department
ECHO ---------------------------------------------------------------
ECHO  Hello there fellow student! this program will assist you
ECHO  in the installation of:
ECHO    1. %PROVIDER%
ECHO    2. JetBrains CLion %CLION_VERSION%
ECHO ---------------------------------------------------------------
GOTO :EOF

:: Print a friendly footer
:: Arguments: --
:footer
ECHO  
ECHO  The installation is now complete. The command line utilities
ECHO  to compile and run C programs will be avaible after rebooting
ECHO  your computer.
ECHO  
ECHO  You may now close this window and remove the files. Bye!
ECHO ---------------------------------------------------------------
GOTO :EOF

:: Install the GNU environment to compile and
:: run C programs
:: Arguments: the selected environment (CYGWIN, MINGW)
:install_environment
ECHO  + Downloading %PROVIDER%
CALL :download "%PROVIDER%" %PROVIDER_URL% "%PROVIDER_FILE%"
IF "%~1"=="CYGWIN" (
    ECHO  + Installing %PROVIDER%
    %PROVIDER_FILE% ^
        --wait --no-desktop --no-shortcuts --no-startmenu ^
        --quiet-mode --root %PROVIDER_ROOT% --site http://muug.ca/mirror/cygwin ^
        -P wget -P gcc-g++ -P make -P diffutils -P libmpfr-devel -P libgmp-devel ^
        -P libmpc-devel -P gdb > NUL
) ELSE IF "%~1"=="MINGW" (
    ECHO  + Extracting %PROVIDER%. This may take several minutes
    ECHO files\extra\7za-%ARCH%.exe x %PROVIDER_FILE% -y -o%SystemDrive%
    files\extra\7za-%ARCH%.exe x %PROVIDER_FILE% -y -o%SystemDrive%
    IF EXIST "%PROVIDER_ROOT%\" RD /q /s %PROVIDER_ROOT%
    MOVE %SystemDrive%\mingw%ARCHNUM% %PROVIDER_ROOT%
)
:: Add executables to the PATH
ECHO  + Updating the PATH variable
CMD /c ""files\extra\pathmgr.bat" /add /y %PROVIDER_ROOT%\bin" > NUL
GOTO :EOF

:: Download and install CLion
:: Arguments: --
:install_clion
ECHO  + Downloading CLion %CLION_VERSION%
CALL :download "CLion %CLION_VERSION%" "%CLION_URL%" "%CLION_FILE%"
ECHO  + Installing %CLION_VERSION%
%CLION_FILE% > NUL
GOTO :EOF

:: Downloads a given URL using wget
:: Arguments: file name, URL, output file
:download
START "Downloading %~1 - DO NOT CLOSE THIS WINDOW" /WAIT^
    files\extra\curl.exe -k -L -C - %2 -o %3
GOTO :EOF
