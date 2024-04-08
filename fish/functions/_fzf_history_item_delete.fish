function _fzf_history_item_delete --description "Delete a history item from the fzf selection"
    set split (string split0 $argv)
    set replaced (string replace --regex '^.*? │ ' '' $split)
    builtin history delete --exact --case-sensitive $replaced
    if test $status -eq 0
        echo "Deleted history item"
    else
        echo "Failed to delete history item"
    end
end
