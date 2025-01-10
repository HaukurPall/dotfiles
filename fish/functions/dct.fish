function dct
	# check if DISTRO_CONFIG_TRACKER_DIR is set
    if not set -q DISTRO_CONFIG_TRACKER_DIR
		echo "DISTRO_CONFIG_TRACKER_DIR is not set"
		return 1
    end
    # check if the directory exists
    if not test -d $DISTRO_CONFIG_TRACKER_DIR
    	echo "DISTRO_CONFIG_TRACKER_DIR is not a directory"
		return 1
	end
	# execute the command
    git --git-dir=$DISTRO_CONFIG_TRACKER_DIR --work-tree=/ $argv
end

