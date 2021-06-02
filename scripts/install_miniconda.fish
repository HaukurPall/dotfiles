#!/usr/bin/fish
function install_miniconda
    wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.9.2-Linux-x86_64.sh -O ~/miniconda.sh
    bash ~/miniconda.sh -b -p $CONDA_HOME
    rm ~/miniconda.sh
end

if test $CONDA_HOME
    echo "Testing if conda is installed at $CONDA_HOME"
    test -d $CONDA_HOME
    if test $status -eq 1
        echo "Installing miniconda"
        install_miniconda
    else
        echo "Miniconda is installed"
    end
else
    echo "CONDA_HOME is not define for this machine. Fix it!"
end
