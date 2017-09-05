# CLion Installer
Scripts to facilitate CLion installation on Windows, Mac and Linux.

## Instructions

First of all, download these files from here: https://github.com/jachinte/clion-installer/archive/master.zip and then extract them.

### Windows

On Windows, CLion may be installed along with either Cygwin or MinGW. If you know what these are, double click on file `run-advanced.bat`; you'll be asked which one you'd like to install. If you just want CLion to work (a.k.a. I don't know the difference between those two), double click on file `run.bat`.

### Mac and Linux

Open a terminal window, then navigate to the corresponding folder (e.g., cd ~/Downloads/clion-installer/mac) and execute the command `bash install.sh`. On a Mac, the application is installed in `/Applications`. On a Linux, CLion is extracted in the `/opt` folder and an alias is added to the user's `.bash_aliases` file; to open the IDE, execute `clion` on a terminal.
