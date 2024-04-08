function _fzf_history_command --description "Create a history search list for the fzf selection"
    set -f fzf_history_time_format "%m-%d %H:%M:%S"
    builtin history --null --show-time="$fzf_history_time_format │ "
end
