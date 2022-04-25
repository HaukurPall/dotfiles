#!/usr/bin/fish
wget https://github.com/junegunn/fzf/releases/download/0.30.0/fzf-0.30.0-linux_amd64.tar.gz -O fzf.tar.gz
tar -xf fzf.tar.gz
cp fzf ~/.local/bin/
wget https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.fish -O fish/functions/fzf_key_bindings.fish # Not versioned, will break
rm fzf.tar.gz fzf
