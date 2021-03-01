# Disable welcome message
set -Ux fish_greeting

# Use local installation before system.
set -x PATH $HOME/.local/bin $PATH

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

# If 'fzf' is installed, use it for history search in fish
if type -q fzf
    fzf_key_bindings
    set -gx FZF_DEFAULT_COMMAND "fd --type f"
    set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border"
end

# If powerline shell is installed, use it for the fish promt
if type -q powerline-shell
    function fish_prompt
        powerline-shell --shell bare $status
    end
end

# If pyenv is installed, initialize it.
if type -q pyenv
    pyenv init - | source
end