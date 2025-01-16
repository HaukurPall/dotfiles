#!/usr/bin/fish
# Disable welcome message
set -g fish_greeting
# Set vi mode
set -g fish_key_bindings fish_vi_key_bindings
# Do not shorten the prompt path
set -g fish_prompt_pwd_dir_length 0
# Pager - always use less
set -gx PAGER less

# Use local installation before system.
fish_add_path $HOME/.local/bin

# Useful aliases/functions
alias less='less -N'
alias sq="squeue -O \"JobID:.6,Partition:.9,UserName:.9,State:.8 ,Name:35,NumCPUs:.8,tres-per-job:.10,tres-per-node:.10,TimeUsed:.12,TimeLeft:.12 ,Command:.20\" -S \"-S\""

# Abbreviations
# git
abbr gadd 'git add --all'
abbr gcm 'git commit -m'
abbr gs 'git status'
abbr gpl 'git pull'
abbr gps 'git push'

# If 'bat' is installed
if type -q bat
    # use it as a man pager
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
    # required to avoid formatting issues
    set -gx MANROFFOPT -c
    # define bathelp to parse help output
    function bathelp --description 'Parse help output with bat'
        bat --language=help --color=always --style=grid --line-range :500 --wrap=never --pager=never $argv
    end
end
# If 'eza' is installed, use it instead of 'ls'
if type -q eza
    # eza > ls
    alias ls='eza --classify'
    alias ll='ls --header --long --git'
    alias tree='ls --tree'
end
# If 'vim' is installed it's the editor
if type -q vim
    set -gx EDITOR vim
end
# If 'zedit' is installed, use it as the editor and visual editor
if type -q zedit
    set -gx EDITOR "zedit --wait"  # --wait is required to wait for file edits before returning
    set -gx VISUAL "zedit --wait"
end
# If the shell is started via vscode
if test "$TERM_PROGRAM" = vscode
    # set the visual editor to vscode
    set -gx VISUAL code
end

# If fzf is installed - we assume the fish plugin PatrickF1/fzf.fish is installed
if type -q fzf
    # the default height of the fzf window provided is a little large, we want to reduce it
    # sadly, we have to overwrite the default options to do this
    # the default options below are copied from the plugin source _fzf_wrapper.fish
    set --export FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=70% --preview-window=wrap --marker="*"'
    # Add a function to delete history items
    # This is brittle and may break if the plugin changes
    set fzf_history_opts --bind="ctrl-d:execute(_fzf_history_item_delete {})+reload(_fzf_history_command)"
end

# Store the hostname - it's expensive to call
set -l l_hostname (hostname)
if test "$l_hostname" = ada
    or test "$l_hostname" = mideind-gpu-a100-temp
    # Be sure to set CUDA_VISIBLE_DEVICES on ada
    set -gx CUDA_VISIBLE_DEVICES "$CUDA_VISIBLE_DEVICES"
end

for secret_file in $HOME/secrets/*.fish
    source $secret_file
end
