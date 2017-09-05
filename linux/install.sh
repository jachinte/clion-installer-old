#!/bin/bash

# install.sh
# Author: Miguel Jimenez
# Date  : August 10, 2017
#
# Downloads and installs CLion for linux.
#
CLION_VERSION="2017.2.1"
CLION_FILE="CLion-$CLION_VERSION.tar.gz"
CLION_URL="https://download-cf.jetbrains.com/cpp/$CLION_FILE"
CLION_EXECUTABLE="/opt/clion-$CLION_VERSION/bin/clion.sh"
INPUT_PASSWORD_MSG="Your password may be asked in order to extract the files."

echo ---------------------------------------------------------------
echo                   University of Victoria
echo                 Computer Science Department
echo ---------------------------------------------------------------
echo  Hello there fellow student! this program will assist you
echo  in the installation of JetBrains CLion v$CLION_VERSION
echo ---------------------------------------------------------------

# Download and install CLion for linux
echo + Downloading the CLion installer
echo 
wget -c -O $CLION_FILE $CLION_URL

echo + Extracting files
echo -e "$INPUT_PASSWORD_MSG\n"
sudo tar xf $CLION_FILE -C /opt/ &> /dev/null
echo
echo

# Add alias to open the IDE
if ! command -V clion > /dev/null 2>&1; then
	echo "# This alias was automatically created on $(date)" >> ~/.bash_aliases
	echo "alias clion='$CLION_EXECUTABLE & disown'" >> ~/.bash_aliases
	echo  The \'clion\' alias was created in your .bash_aliases file.
else
	echo The command clion was not set because it already exists.
fi
# Source the aliases
. ~/.bash_aliases

echo  To open the IDE, execute the command \'clion\' in a terminal. In case
echo  the command is not recognised, execute \'source ~/.bash_aliases\' and
echo  try again.
echo 
echo  You may now close this window and remove the files. Bye!
echo ---------------------------------------------------------------
