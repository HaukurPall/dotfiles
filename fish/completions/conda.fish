function __fish_conda_needs_command
    set cmd (commandline -opc)
    if [ (count $cmd) -eq 1 -a $cmd[1] = conda ]
        return 0
    end
    return 1
end

function __fish_conda_using_command
    set cmd (commandline -opc)
    if [ (count $cmd) -gt 1 ]
        if [ $argv[1] = $cmd[2] ]
            return 0
        end
    end
    return 1
end

function __fish_conda_env_commands
    string replace -r '.*_([a-z]+)\.py$' '$1' $_CONDA_ROOT/lib/python*/site-packages/conda_env/cli/main_*.py
end

function __fish_conda_envs
    conda config --json --show envs_dirs | python -c "import json, os, sys; from os.path import isdir, join; print('\n'.join(d for ed in json.load(sys.stdin)['envs_dirs'] if isdir(ed) for d in os.listdir(ed) if isdir(join(ed, d))))"
end

function __fish_conda_packages
    conda list | awk 'NR > 3 {print $1}'
end

function __fish_conda_commands
    string replace -r '.*_([a-z]+)\.py$' '$1' $_CONDA_ROOT/lib/python*/site-packages/conda/cli/main_*.py
    for f in $_CONDA_ROOT/bin/conda-*
        if test -x "$f" -a ! -d "$f"
            string replace -r '^.*/conda-' '' "$f"
        end
    end
    echo activate
    echo deactivate
end

complete -f -c conda -n __fish_conda_needs_command -a '(__fish_conda_commands)'
complete -f -c conda -n '__fish_conda_using_command env' -a '(__fish_conda_env_commands)'

# Commands that need environment as parameter
complete -f -c conda -n '__fish_conda_using_command activate' -a '(__fish_conda_envs)'

# Commands that need package as parameter
complete -f -c conda -n '__fish_conda_using_command remove' -a '(__fish_conda_packages)'
complete -f -c conda -n '__fish_conda_using_command uninstall' -a '(__fish_conda_packages)'
complete -f -c conda -n '__fish_conda_using_command upgrade' -a '(__fish_conda_packages)'
complete -f -c conda -n '__fish_conda_using_command update' -a '(__fish_conda_packages)'
