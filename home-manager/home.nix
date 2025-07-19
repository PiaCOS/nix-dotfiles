{ config, pkgs, ... }:

# nix run home-manager/master -- switch --flake ~/.config/home-manager/#default
# nix flake update

{
  # home.username = "odoo";
  # home.homeDirectory = "/home/odoo";
  home.username = "pia";
  home.homeDirectory = "/home/pia";

  home.stateVersion = "23.11"; # Please read the comment before changing.
  
  home.packages = with pkgs; [
    # Important
    fish
    git
    helix
    kitty
    tmux
    vim
    
    # Languages
    nodejs
    postgresql
    python3
    rustup

    # LSP
    pyright
    ruff
    typescript-language-server
    vscode-langservers-extracted

    # Tools
    fastfetch
    fzf
    gh
    hyfetch
    lazygit
    ripgrep
    yazi
    termusic
    zellij

    # Fonts
    maple-mono.truetype
    maple-mono.NF-unhinted
    maple-mono.NF-CN-unhinted
  ];

  home.file = {
    # Config
    ".config/helix/config.toml".source = ./helix/config.toml;
    ".config/helix/languages.toml".source = ./helix/languages.toml;

    ".config/kitty/kitty.conf".source = ./kitty/kitty.conf;
    ".config/kitty/current-theme.conf".source = ./kitty/noirbuddy-oxide.conf;

    ".config/fish/config.fish".source = ./fish/config.fish;
    ".config/fish/conf.d".source = ./fish/conf.d;
    ".config/fish/functions".source = ./fish/functions;

    ".tmux.conf".source = ./tmux/tmux.conf;

    # Scripts
    "bin/run_odoo.py" = {
      source = ./scripts/run_odoo.py;
      executable = true;
    };
    "bin/drop_db.sh" = {
      source = ./scripts/drop_db.sh;
      executable = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "hx";
  };

  # SWAY
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
    config = rec {
      input = {
        "*" = {
          xkb_layout = "fr";
        };
      };
      modifier = "Mod4";
      terminal = "kitty"; 
    };
  };
  services.gnome-keyring.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
