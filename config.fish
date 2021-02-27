# Disable welcome message
set -Ux fish_greeting

set -gx EDITOR vim


# fzf
fzf_key_bindings
set -gx FZF_DEFAULT_COMMAND "fd --type f"
set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border"


# Powerline shell
if type -q powerline-shell
    function fish_prompt
        powerline-shell --shell bare $status
    end
end

# exa > ls
alias ls='exa --classify'
alias ll='ls --header --long --git'

# PATH
set -x PATH $PATH ~/.poetry/bin
# PyENV
pyenv init - | source