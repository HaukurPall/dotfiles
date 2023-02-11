#!/usr/bin/fish
set APP_NAME "Notion"
set WEBSITE "https://www.notion.so/"


function create_nativfier_desktop_file -a APP_NAME
    set DESKTOP_FILE "$APP_NAME.desktop"
    set APP_FOLDER "$APP_NAME-linux-x64"
    set APP_INSTALL_DIR "$TOOLS_DIR/$APP_FOLDER"

    echo "[Desktop Entry]" > $DESKTOP_FILE
    echo "Name=$APP_NAME" >> $DESKTOP_FILE
    echo "Version=1.0" >> $DESKTOP_FILE
    echo "Type=Application" >> $DESKTOP_FILE
    echo "Exec=$APP_INSTALL_DIR/$APP_NAME" >> $DESKTOP_FILE
    echo "Comment=Application" >> $DESKTOP_FILE
    echo "Icon=$APP_INSTALL_DIR/resources/app/icon.png" >> $DESKTOP_FILE
end

function install_nativfier_app -a APP_NAME WEBSITE
    set DESKTOP_FILE "$APP_NAME.desktop"
    set APP_FOLDER "$APP_NAME-linux-x64"
    set APP_INSTALL_DIR "$TOOLS_DIR/$APP_FOLDER"
    # If the directory exists, we will make a backup and then upgrade the app
    if test -d "$APP_INSTALL_DIR"
        echo "Found previous installation - upgrading"
        cp -r "$APP_INSTALL_DIR" "$APP_INSTALL_DIR.bak"
        docker \
            run \
            --rm \
            -v $TOOLS_DIR:/target/ \
            nativefier/nativefier \
            --name $APP_NAME \
            --single-instance \
            --honest \
            --upgrade /target/$APP_FOLDER
    # otherwise we just install it and create a desktop file
    else
        docker \
            run \
            --rm \
            -v $TOOLS_DIR:/target/ \
            nativefier/nativefier \
            $WEBSITE \
            --name $APP_NAME \
            --single-instance \
            --icon ~/Downloads/Notion_app_logo.png \
            --honest \
            /target/
            
        create_nativfier_desktop_file $APP_NAME 
        desktop-file-install --dir=$HOME/.local/share/applications $DESKTOP_FILE --delete-original

    end
end

install_nativfier_app $APP_NAME $WEBSITE
