function nativefier

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
                $WEBSITE \
                --user-agent "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:70.0) Gecko/20100101 Firefox/70.0" \
                --name $APP_NAME \
                --single-instance \
                --upgrade /target/$APP_FOLDER
        # otherwise we just install it and create a desktop file
        else
            docker \
                run \
                --rm \
                -v $TOOLS_DIR:/target/ \
                nativefier/nativefier \
                $WEBSITE \
                --user-agent "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:70.0) Gecko/20100101 Firefox/70.0" \
                --name $APP_NAME \
                --single-instance \
                /target/
                
            create_nativfier_desktop_file $APP_NAME 
            desktop-file-install --dir=$HOME/.local/share/applications $DESKTOP_FILE --delete-original

        end

    end
end
