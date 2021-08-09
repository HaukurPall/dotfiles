#!/usr/bin/fish
function get_architecture
    set ARCHITECTURE (uname -m)
    if test string match -q "x86_64" $ARCHITECTURE
        echo "x86_64 detected"
    else if test string match -q "armv7*" $ARCHITECTURE
        echo "armv7 detected"
        set ARCHITECTURE "armv7"
    end
    return $ARCHITECTURE
end

function install_exa
    set EXA_VERSION $argv[1]
    set ARCHITECTURE $argv[2]
    wget https://github.com/ogham/exa/releases/download/$EXA_VERSION/exa-linux-$ARCHITECTURE-$EXA_VERSION.zip
    unzip exa-linux-$ARCHITECTURE-$EXA_VERSION.zip
    rm exa-linux-$ARCHITECTURE-$EXA_VERSION.zip
    mv exa-linux-$ARCHITECTURE-$EXA_VERSION/bin/exa ~/.local/bin/exa
    rm -r exa-linux-$ARCHITECTURE-$EXA_VERSION 

if type -q exa
    echo "exa is installed"
else
    set EXA_VERSION "v0.10.1"
    echo "installing exa $EXA_VERSION"
    # Check the architecture
    set ARCHITECTURE get_architecture
    # Install exa
    install_exa $EXA_VERSION $ARCHITECTURE
end
