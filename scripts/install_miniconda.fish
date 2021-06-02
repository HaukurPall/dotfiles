#!/usr/bin/fish
function install_miniconda
    wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.9.2-Linux-x86_64.sh -O ~/miniconda.sh
    bash ~/miniconda.sh -b -p $CONDA_HOME
    rm ~/miniconda.sh
end

if test $CONDA_HOME
    if ! test -d $CONDA_HOME
        echo "Installing miniconda"
        install_miniconda
    end
    set -gx PATH $CONDA_HOME/bin $PATH
    eval conda "shell.fish" "hook" $argv | source
else
    echo "CONDA_HOME is not define for this machine. Fix it!"
end