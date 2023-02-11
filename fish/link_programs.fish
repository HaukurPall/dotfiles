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

