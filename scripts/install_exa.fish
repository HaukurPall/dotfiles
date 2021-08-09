#!/usr/bin/fish

function install_exa
    set EXA_VERSION $argv[1]
    set ARCHITECTURE $argv[2]
    wget https://github.com/ogham/exa/releases/download/$EXA_VERSION/exa-linux-$ARCHITECTURE-$EXA_VERSION.zip
    set TARGET exa-linux-$ARCHITECTURE-$EXA_VERSION
    mkdir -p $TARGET
    unzip $TARGET.zip -d $TARGET
    rm $TARGET.zip
    mv $TARGET/bin/exa ~/.local/bin/exa
    rm -r $TARGET
end

if type -q exa
    echo "exa is installed"
else
    set EXA_VERSION "v0.10.1"
    echo "installing exa $EXA_VERSION"
    # Check the architecture
    set ARCHITECTURE (get_architecture)
    # Install exa
    install_exa $EXA_VERSION $ARCHITECTURE
end
