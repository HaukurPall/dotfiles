#!/usr/bin/fish
# Disable welcome message
set -gx fish_greeting
set -g fish_prompt_pwd_dir_length 0

# Store the hostname - it's expensive to call
set -l l_hostname (hostname)
if test "$l_hostname" = manjaro
    set -gx CONDA_HOME $HOME/.local/miniconda3
    set -x PATH $HOME/.cargo/bin $PATH
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"^C

else if test "$l_hostname" = birta
    set -gx CONDA_HOME /data2/scratch/haukurpj/miniconda3

else if test "$l_hostname" = ada 
     or test "$l_hostname" = mideind-gpu-a100-temp
    # CONDA_HOME is universally
    set -gx HF_HOME /data/scratch/haukurpj/huggingface_cache
    set -gx TRANSFORMERS_CACHE /data/scratch/haukurpj/transformers_cache
    set -gx CUDA_VISIBLE_DEVICES "$CUDA_VISIBLE_DEVICES"
    alias sq="squeue -O \"JobID:.6,Partition:.9,UserName:.9,State:.8 ,Name:35,NumCPUs:.8,tres-per-job:.10,tres-per-node:.10,TimeUsed:.12,TimeLeft:.12 ,Command:.20\" -S \"-S\""
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

else if test "$l_hostname" = maja
    set -gx CONDA_HOME /data2/scratch/haukurpj/miniconda3

else if test "$l_hostname" = pallas
    set -gx CONDA_HOME /data2/scratch/haukurpj/miniconda3

end

for secret_file in $HOME/Secrets/*.fish
    source $secret_file
end

# Define the tool location
set -gx TOOLS_DIR $HOME/Tools

# Use local installation before system.
set -x PATH $TOOLS_DIR/bin $PATH
set -x PATH $HOME/.local/bin $PATH

# Useful aliases/functions
# Make less nice
alias less='less -S -N'
alias tsvsplit="sed G | tr '\t' '\n'"

# Aliases for installed programs
source ~/.config/fish/link_programs.fish

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
