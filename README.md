# Dotfiles
Install via package manager
- fish
- exa
- fd

```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage ~/.local/bin/nvim
```

## Install
```
git clone git@github.com:HaukurPall/dotfiles.git && cd dotfiles && ./install
```

## Desktop ENV
Gnome settings
```
dconf dump /org/gnome/shell/extensions/materialshell/ > ~/dotfiles/user.conf
dconf load /org/gnome/shell/extensions/materialshell/ < ~/dotfiles/user.conf
```
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
