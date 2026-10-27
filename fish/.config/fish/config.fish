if status is-interactive
    #INFO: paths
    fish_add_path -p ~/.fly/bin
    switch (uname -s)
      case "Linux"
        fish_add_path -p /etc/profile
        fish_add_path -p ~/.bash_profile
        fish_add_path -p /etc/bash.bashrc
        fish_add_path -p ~/.bashrc
        fish_add_path -p /usr/local/go/bin
        fish_add_path -p ~/go/bin/
        fish_add_path -p /home/jason/.cargo/bin/ 
      case "Darwin"
        fish_add_path -p /opt/homebrew/bin
        fish_add_path -p /etc/profile  
        fish_add_path -p ~/.bash_profile 
        fish_add_path -p /etc/bash.bashrc
        fish_add_path -p ~/.bashrc
        fish_add_path -p /usr/local/go/bin
        fish_add_path -p ~/go/bin/
        fish_add_path -p ~/.local/share/nvm/
        fish_add_path -p ~/Library/Application
        fish_add_path -p /opt/homebrew/Cellar/zigup/2025.05.24/bin
        # fish_add_path -p /opt/homebrew/opt/mariadb@11.8/bin
        # fish_add_path -p ~/.local/bin
    end

    #bun path vars
    set --export BUN_INSTALL "$HOME/.bun"
    set --export PATH $BUN_INSTALL/bin $PATH

    # Added by OrbStack: command-line tools and integration
    # This won't be added again if you remove it.
    source ~/.orbstack/shell/init2.fish 2>/dev/null || :

    #INFO: Multiplexer
    function is_valid_command
        if which $argv[1] > /dev/null
            true
        else
            false
        end
    end

    if command -q herdr
        set -l sessions (herdr session list 2>/dev/null)
        if test -z "$sessions"
            herdr
        end
    end


    #INFO: fish theme and styling
    #./conf.d/theme.fish

    #INFO: ALIASES
    #./conf.d/aliases.fish

    #INFO: fzf
    #./conf.d/fzf

    #INFO: BINDINGS
    #./conf.d/bindings.fish
end


