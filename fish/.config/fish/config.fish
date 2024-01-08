if status is-interactive
    function is_valid_command
        if which $argv[1] > /dev/null
            true
        else
            false
        end
    end

    # logo-ls is for icons for ls https://github.com/Yash-Handa/logo-ls
    if is_valid_command logo-ls
      alias ls="logo-ls"
    end
    
    alias n="nvim"

    #useful functions
    #cd and ls
    function cdl
      cd $argv && ls
    end

    if is_valid_command z
      function zl
        z $argv && ls
      end
    end

    fish_add_path -p  /usr/local/bin /usr/bin /etc/profile ~/.bash_profile /etc/bash.bashrc ~/.bashrc ~/go/bin /usr/local/go/bin /opt/homebrew/bin/fish /opt/homebrew/bin
    set fish_greeting

    # Icons for hydro theme https://github.com/jorgebucaran/hydro
    set --global hydro_symbol_prompt '󰈺'
    set --global hydro_symbol_git_dirty ' ≠ '
    set --global hydro_symbol_git_ahead '↑  '
    set --global hydro_symbol_git_behind '↓  '
    set --global hydro_color_pwd $fish_color_cwd
    set --global hydro_color_prompt $fish_color_param
end

