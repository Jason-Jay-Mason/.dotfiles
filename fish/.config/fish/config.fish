if status is-interactive
    function is_valid_command
        if which $argv[1] > /dev/null
            true
        else
            false
        end
    end

    #auto start tmux
    if is_valid_command tmux
      if not tmux info | grep -q "Terminal"
        tmux
      end
    end


    # Air is a hot reload for go
    # alias air="~/go/bin/air"

    alias n="nvim"

    #useful functions

    #logo ls instead of ls
    function ls
        logo-ls $argv
    end

    function secrets
        if test "$argv[1]" = "open"
            # Check if secrets.locked.yml exists in current directory
            if test -f "secrets.locked.yml"
                # Run ansible-vault decrypt and capture the exit status
                ansible-vault decrypt secrets.locked.yml
                set -l decrypt_status $status
                
                # If the command was successful (exit status 0), rename the file
                if test $decrypt_status -eq 0
                    mv secrets.locked.yml secrets.open.yml
                    echo "Successfully decrypted and renamed to secrets.open.yml"
                else
                    echo "Decryption failed. File name remains unchanged."
                end
            else
                echo "Error: secrets.locked.yml not found in current directory"
            end
        else if test "$argv[1]" = "lock"
            # Check if secrets.open.yml exists in current directory
            if test -f "secrets.open.yml"
                # Run ansible-vault encrypt and capture the exit status
                ansible-vault encrypt secrets.open.yml
                set -l encrypt_status $status
                
                # If the command was successful (exit status 0), rename the file
                if test $encrypt_status -eq 0
                    mv secrets.open.yml secrets.locked.yml
                    echo "Successfully encrypted and renamed to secrets.locked.yml"
                else
                    echo "Encryption failed. File name remains unchanged."
                end
            else
                echo "Error: secrets.open.yml not found in current directory"
            end
        else
            echo "Usage: secrets [open|lock]"
        end
    end

    #fzf funcs
      set -gx FZF_PREVIEW_OPTS \
       --ansi \
       --layout=reverse \
       --preview "echo {} | sed 's/^.* //g' | xargs bat --color=always --plain --theme=ansi" \
       --preview-window "~3,noborder" \
       --color=16 \
       --bind 'ctrl-d:page-down,ctrl-u:page-up'

      set -gx FZF_NO_PREVIEW_OPTS \
         --color=16 \
         --no-border \
         --layout=reverse \
         --bind 'ctrl-d:page-down,ctrl-u:page-up'

    function fzf_with_icons
       set -l source_cmd $argv[1]
       set -l result_cmd $argv[2] 
       set -l fzf_opts $argv[3..-1]  
       
       # Run the pipeline with icons and preview
       set -l result (eval $source_cmd | devicon-lookup -i -p : | fzf $fzf_opts | sed 's/^.* //g')
       
       if test -n "$result"
           eval "$result_cmd '$result'"
       end
    end

    function fls
        if contains -- '-a' $argv
            fzf_with_icons "fd --hidden --exclude .git --max-depth 1" "cd" $FZF_PREVIEW_OPTS
        else
            fzf_with_icons "fd --exclude .git --max-depth 1" "cd" $FZF_PREVIEW_OPTS
        end
    end

    function ll
        command logo-ls -l 
    end

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


    fish_add_path -p /etc/profile ~/.bash_profile /etc/bash.bashrc ~/.bashrc /usr/local/go/bin ~/go/bin/ ~/.fly/bin
    switch (uname -s)
      case "Linux"
        fish_add_path -p /etc/profile ~/.bash_profile /etc/bash.bashrc ~/.bashrc /usr/local/go/bin ~/go/bin/ /home/jason/.cargo/bin/ 
      case "Darwin"
        fish_add_path -p /etc/profile  
        fish_add_path -p ~/.bash_profile 
        fish_add_path -p /etc/bash.bashrc
        fish_add_path -p ~/.bashrc
        fish_add_path -p /usr/local/go/bin
        fish_add_path -p ~/go/bin/
        fish_add_path -p /opt/homebrew/bin
        fish_add_path -p ~/.local/share/nvm/
        fish_add_path -p ~/Library/Application
        fish_add_path -p /opt/homebrew/Cellar/zigup/2025.05.24/bin
    end
    set fish_greeting

    # Icons for hydro theme https://github.com/jorgebucaran/hydro
    switch (uname -s)
      case "Linux"
        set --global hydro_symbol_prompt '󰈺 '
      case "Darwin"
        set --global hydro_symbol_prompt '󰈺'
    end
    set --global hydro_symbol_git_dirty ' ≠ '
    set --global hydro_symbol_git_ahead '↑  '
    set --global hydro_symbol_git_behind '↓  '
    set --global hydro_color_pwd $fish_color_cwd
    set --global hydro_color_prompt $fish_color_param
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

#fzf
#set -gx FZF_DEFAULT_OPTS "--preview 'bat --color=always --plain --theme=ansi {}' --preview-window '~3,noborder' --color=16"



# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
