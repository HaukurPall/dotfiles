# Dotfiles
Manually install
- fish
- fzf
- exa
- powerline-shell
- neovim
- pypoetry
```
git clone https://github.com/HaukurPall/dotfiles.git && cd dotfiles && ./install
```

Gnome settings
```
dconf dump /org/gnome/shell/extensions/materialshell/ > ~/dotfiles/user.conf
dconf load /org/gnome/shell/extensions/materialshell/ < ~/dotfiles/user.conf
```
