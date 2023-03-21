#!/usr/bin/fish
# Disable welcome message
set -g fish_greeting
# Set vi mode
set -g fish_key_bindings fish_vi_key_bindings
# Do not shorten the prompt path
set -g fish_prompt_pwd_dir_length 0
# Pager - always use less
set -gx PAGER less
# Define the tool location
set -g TOOLS_DIR $HOME/Tools

# Use local installation before system.
fish_add_path $TOOLS_DIR/bin
fish_add_path $HOME/.local/bin

# Useful aliases/functions
# Make less nice
alias less='less -N'
alias tsvsplit="sed G | tr '\t' '\n'"
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
    # define bathelp to parse help output
    function bathelp --description 'Parse help output with bat'
        bat --language=help --color=always --style=grid --line-range :500 --wrap=never --pager=never $argv
    end
end
# If 'exa' is installed, use it instead of 'ls'
if type -q exa
    # exa > ls
    alias ls='exa --classify'
    alias ll='ls --header --long --git'
    alias tree='ls --tree'
end
# If 'vim' is installed, use it instead of 'vi'
if type -q vim
    alias vi=vim
    set -gx EDITOR vim
end
# If 'nvim' is installed, use it instead of 'vi' or 'vim'
if type -q nvim
    alias vi=nvim
    alias vim=nvim
    set -gx EDITOR nvim
end
# If the shell is started via vscode
if test "$TERM_PROGRAM" = "vscode"
    # set the editor to vscode
    set -gx EDITOR code
    # and source the vscode integration (still testing it) - maybe causing issues with keyring?
    # source (code --locate-shell-integration-path fish)
end

# If conda is installed (at CONDA_HOME - universal variable)
if test -n "$CONDA_HOME"
    set -gx CONDA_EXE "$CONDA_HOME/bin/conda"
    set _CONDA_ROOT "$CONDA_HOME"
    set _CONDA_EXE "$CONDA_HOME/bin/conda"
    set -gx CONDA_PYTHON_EXE "$CONDA_HOME/bin/python"
    set -gx PATH $_CONDA_ROOT/condabin $PATH

    if not set -q CONDA_SHLVL
        set -gx CONDA_SHLVL 0
    end
end

# Store the hostname - it's expensive to call
set -l l_hostname (hostname)
if test "$l_hostname" = ada 
     or test "$l_hostname" = mideind-gpu-a100-temp
    # Be sure to set CUDA_VISIBLE_DEVICES on ada
    set -gx CUDA_VISIBLE_DEVICES "$CUDA_VISIBLE_DEVICES"
end

for secret_file in $HOME/Secrets/*.fish
    source $secret_file
end
