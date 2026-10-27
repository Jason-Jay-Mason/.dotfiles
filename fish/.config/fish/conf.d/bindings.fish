function search_cmd_history
    set -l result (history | fzf $FZF_NO_PREVIEW_OPTS)
    if test -n "$result"
        commandline -i "$result"
    end
end
bind \ch 'search_cmd_history'

function tab_complete_to_fzf
    # Get current token at cursor
    set -l token (commandline -t)
    # Get all completions for this token
    set -l completions (complete -C (commandline -p))
    if test -n "$completions"
        # Format completions to show description but only select command
        set -l result (printf "%s\n" $completions | \
            sed -E 's/\t/ │ /' | \
            fzf $FZF_NO_PREVIEW_OPTS | \
            cut -d' ' -f1)
        if test -n "$result"
            # Remove the current token
            commandline -t ""
            # Insert the selected completion
            commandline -i -- "$result"
        end
    end
end
bind \t 'tab_complete_to_fzf'
