#!/usr/bin/fish
if type -q fzf
    echo "fzf is installed"
else
    echo "Installing fzf"
    ./fzf/install --no-update-rc --no-fish --no-zsh --no-bash
end
