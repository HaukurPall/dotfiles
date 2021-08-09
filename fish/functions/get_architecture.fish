
function get_architecture
    set ARCHITECTURE (uname -m)
    if string match -q "armv7*" $ARCHITECTURE
        set ARCHITECTURE "armv7"
    end
    echo $ARCHITECTURE
end
