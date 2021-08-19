#!/usr/bin/fish
set APP_NAME "Roam"
set WEBSITE "https://roamresearch.com/\#/app/Grunnur"

# Expose the nativefier functions
nativefier
install_nativfier_app $APP_NAME $WEBSITE
