# Disable welcome message
set -Ux fish_greeting
# Lengthen the cwd of promt
set -g fish_prompt_pwd_dir_length 0

if test (hostname) = "manjaro"
    set -gx CONDA_HOME $HOME/.local/miniconda3
else if test (hostname) = "birta"
    set -gx CONDA_HOME /data2/scratch/haukurpj/miniconda3
else if test (hostname) = "ada"
    set -gx CONDA_HOME /data/scratch/haukurpj/miniconda3
else if test (hostname) = "maja"
    set -gx CONDA_HOME /data2/scratch/haukurpj/miniconda3
else if test (hostname) = "pallas"
    set -gx CONDA_HOME /data2/scratch/haukurpj/miniconda3
end

# Use local installation before system.
set -x PATH $HOME/.local/bin $PATH

# Initialize conda
if test $CONDA_HOME
    if test -d $CONDA_HOME
        set -gx PATH $CONDA_HOME/bin $PATH
        eval conda "shell.fish" "hook" $argv | source
    end
end

# Disable virtualenv promt
set -x VIRTUAL_ENV_DISABLE_PROMPT 1

# Useful aliases/functions
# Make less nice
alias less='less -S -N'
alias tsvsplit="sed G | tr '\t' '\n'"

# Aliases for installed programs
source ~/.config/fish/link_programs.fish
