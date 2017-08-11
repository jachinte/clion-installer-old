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
CLION_EXECUTABLE="/opt/CLion-$CLION_VERSION/bin/clion.sh"
ALIAS_EXISTS_MSG="The command clion was not set because it already exists"

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
sudo tar xf $CLION_FILE -C /opt/ &> /dev/null

# Add alias to open the IDE
echo + Creating alias
alias clion && echo " $ALIAS_EXISTS_MSG" || \
	echo "# The following alias was automatically created on $(date)" >> ~/.bash_aliases \
	&& echo "alias clion='command'" >> ~/.bash_aliases \
	&& source ~/.bash_aliases

echo 
echo  The "clion" alias was created in your .bash_aliases file. To
echo  open the IDE, execute the command "clion" in a terminal.
echo 
echo  You may now close this window and remove the files. Bye!
echo ---------------------------------------------------------------
