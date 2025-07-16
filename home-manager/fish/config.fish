if status is-interactive
    # Commands to run in interactive sessions can go here

    # ---------------------------------------------------
    # ALIAS STUFF
    # ---------------------------------------------------

    alias ll="ls -lsa"
    abbr -a hms 'nix run home-manager/master -- switch --flake ~/.config/home-manager/#end'

    # clipboard stuff
    alias claptrap="pwd | xclip -selection clipboard"
    abbr --add clap "xclip -selection clipboard"

    # used to sudo last command
    abbr !! --position anywhere --function last_history_item

    # ---------------------------------------------------
    # DEFAULT
    # ---------------------------------------------------

    set -gx EDITOR hx

    # ---------------------------------------------------
    # PATH STUFF
    # ---------------------------------------------------

    # Add cargo to path
    set PATH $HOME/bin $PATH

    # set -x PATH $HOME/.cargo/bin
    set PATH $PATH ~/.cargo/bin

    # Add go to path
    set -x GOPATH $HOME/go
    set -x PATH $PATH $GOPATH/bin

    # Add JDK to path for Ghidra
    set -x PATH $HOME/jdk-21.0.5+11:$PATH

    # Add dotnet to path
    set -x PATH /usr/local/share/dotnet/:$PATH

    # Add Home Manager environment variables
    test -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.fish" && . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.fish"


end
