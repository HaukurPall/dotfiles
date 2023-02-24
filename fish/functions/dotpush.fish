# Push dotfile changes to github
function dotpush
    cd ~/dotfiles
    git add .
    git commit -m "$argv[1]"
    git push
    cd -
end
