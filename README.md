# Dotfiles
Install via package manager
- fish
- exa

```
pip install --user poetry
pip install --user powerline-shell
```

```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage ~/.local/bin/nvim
```

```
git clone --depth 1 https://github.com/junegunn/fzf.git
fzf/install 
--no-key-bindings # Enable/disable key bindings (CTRL-T, CTRL-R, ALT-C)
--no-completion  #  Enable/disable fuzzy completion (bash & zsh)
--no-update-rc
```

## Install
```
git clone https://github.com/HaukurPall/dotfiles.git && cd dotfiles && ./install
```

## Desktop ENV
Gnome settings
```
dconf dump /org/gnome/shell/extensions/materialshell/ > ~/dotfiles/user.conf
dconf load /org/gnome/shell/extensions/materialshell/ < ~/dotfiles/user.conf
```
