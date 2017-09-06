#!/bin/bash

# install.sh
# Author: Miguel Jimenez
# Date  : August 10, 2017
#
# Downloads and installs CLion and Xcode command
# line tools.
#
CLION_VERSION="2017.2.1"
CLION_FILE="CLion-$CLION_VERSION.dmg"
CLION_URL="https://download-cf.jetbrains.com/cpp/$CLION_FILE"
GCC_ERROR_MSG="GCC wasn't installed correctly. Please try again; if the error persists, go to office hours"

echo ---------------------------------------------------------------
echo                   University of Victoria
echo                 Computer Science Department
echo ---------------------------------------------------------------
echo  Hello there fellow student! this program will assist you
echo  in the installation of:
echo    1. XCode command line tools
echo    2. JetBrains CLion v$CLION_VERSION
echo ---------------------------------------------------------------

# Install GCC and verify executable
xcode-select --install &> /dev/null
gcc --version &> /dev/null || (echo $GCC_ERROR_MSG; exit 1)

# Download and install CLion for mac
curl -C - $CLION_URL -o $CLION_FILE
hdiutil attach $CLION_FILE &> /dev/null
ditto /Volumes/CLion/CLion.app /Applications/CLion.app &> /dev/null
hdiutil detach /Volumes/CLion/ &> /dev/null

echo 
echo  The installation is now complete. The command line utilities
echo  to compile and run C programs will be avaible after rebooting
echo  your computer.
echo 
echo  You may now close this window and remove the files. Bye!
echo ---------------------------------------------------------------
