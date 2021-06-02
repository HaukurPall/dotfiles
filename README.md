# Dotfiles
Install via package manager
- fish
- exa
- fd

```
pip install --user powerline-shell
```

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

docker run --rm -v ~/.local/:/target/ nativefier/nativefier https://roamresearch.com/#/app/Grunnur --user-agent "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:70.0) Gecko/20100101 Firefox/70.0" --name Roam --single-instance /target/
cp ~/dotfiles/generic.desktop ~/dotfiles/roam.desktop
sed -i 's|To exec|/home/haukurpj/.local/Roam-linux-x64/Roam|' ~/dotfiles/roam.desktop
sed -i 's|App name|Roam|' ~/dotfiles/roam.desktop
sed -i 's|Add comment|Roam note-taking tool for networked thought.|' ~/dotfiles/roam.desktop
sed -i 's|Add icon|/home/haukurpj/.local/Roam-linux-x64/resources/app/icon.png|' ~/dotfiles/roam.desktop
desktop-file-install --dir=$HOME/.local/share/applications roam.desktop



 gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
