#!/usr/bin/fish
wget https://github.com/sharkdp/fd/releases/download/v8.3.2/fd-v8.3.2-x86_64-unknown-linux-gnu.tar.gz -O fd.tar.gz
tar -xf fd.tar.gz 
cp fd-*/autocomplete/fd.fish fish/completions/cp
cp fd-*/fd ~/.local/bin/
rm -r fd-*
rm fd.tar.gz
