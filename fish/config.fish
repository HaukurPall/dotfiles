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
# If the shell is started via vscode
if test "$TERM_PROGRAM" = vscode
    # set the visual editor to vscode
    set -gx VISUAL code
end

# Store the hostname - it's expensive to call
set -l l_hostname (hostname)
if test "$l_hostname" = ada
    or test "$l_hostname" = mideind-gpu-a100-temp
    # Be sure to set CUDA_VISIBLE_DEVICES on ada
    set -gx CUDA_VISIBLE_DEVICES "$CUDA_VISIBLE_DEVICES"
else if test "$l_hostname" = risi
    set -gx CONDA_HOME /home/haukurpj/projects/miniconda
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


for secret_file in $HOME/Secrets/*.fish
    source $secret_file
end
