# Update dotfiles
function dotup
  cd ~/dotfiles
  git pull
  ./install
  cd -
end