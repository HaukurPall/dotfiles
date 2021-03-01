#!/bin/bash
# Script for installing Fish Shell on systems without root access.
# Fish Shell will be installed in $HOME/.local/bin.
# It's assumed that cmake and make is installed.
# It's assumed that fish-shell has been cloned to the current directory 
# exit on error
set -e

if command -v fish &> /dev/null
then
    echo "Fish already installed"
    exit 0
fi

cd fish-shell
 
# extract files, configure, and compile
mkdir -p build; cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/.local
make
make install
# Change the default shell to fish
chsh -s $HOME/.local/bin/fish