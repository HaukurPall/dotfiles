# Disable welcome message
set -Ux fish_greeting
# Lengthen the cwd of promt
set -g fish_prompt_pwd_dir_length 0

if test (hostname) = manjaro
    set -gx CONDA_HOME $HOME/.local/miniconda3
    set -x PATH $HOME/.cargo/bin $PATH

else if test (hostname) = birta
    set -gx CONDA_HOME /data2/scratch/haukurpj/miniconda3

else if test (hostname) = ada
    set -gx CONDA_HOME /data/scratch/haukurpj/miniconda3
    set -gx HF_HOME /data/scratch/haukurpj/huggingface_cache
    set -gx TRANSFORMERS_CACHE /data/scratch/haukurpj/transformers_cache
    set -gx CUDA_VISIBLE_DEVICES "$CUDA_VISIBLE_DEVICES"
    alias sq="squeue -O \"JobID:.6,Partition:.9,UserName:.9,State:.8 ,Name:35,NumCPUs:.8,tres-per-job:.10,tres-per-node:.10,TimeUsed:.12,TimeLeft:.12 ,Command:.20\" -S \"-S\""


else if test (hostname) = maja
    set -gx CONDA_HOME /data2/scratch/haukurpj/miniconda3

else if test (hostname) = pallas
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

# Initialize conda
if test $CONDA_HOME
    if test -d $CONDA_HOME
        eval $CONDA_HOME/bin/conda "shell.fish" hook $argv | source
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
