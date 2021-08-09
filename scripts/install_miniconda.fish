#!/usr/bin/fish
function install_miniconda
    wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.9.2-Linux-x86_64.sh -O ~/miniconda.sh
    bash ~/miniconda.sh -b -p $CONDA_HOME
    rm ~/miniconda.sh
end

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

if test $CONDA_HOME
    echo "Testing if conda is installed at $CONDA_HOME"
    test -d $CONDA_HOME
    if test $status -eq 1
        if test string match -q "x86_64" get_architecture
            echo "Installing miniconda"
            install_miniconda
        else
            echo "I will not install Minicoda for other than x86_64"
        end
    else
        echo "Miniconda is installed"
    end
else
    echo "CONDA_HOME is not define for this machine. Fix it!"
end
