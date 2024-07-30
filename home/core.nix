{ pkgs, ... }:

{
  # home.stateVersion = "24.05";

  home.packages = with pkgs; [
    bat
    bat-extras.batman
    bat-extras.batgrep
    # bottom
    # du-dust
    duf # disk usage
    fd
    firebase-tools # could be in explore only
    # fish
    # fishPlugins.fzf-fish
    # fishPlugins.z
    glow  # markdown previewer in terminal
    hasura-cli # could be in explore only
    heroku
    # nerdfonts
    # nix-prefetch-git
    # nix-prefetch-github
    # procs
    # ripgrep
    # zoxide
  ];

  programs = {
    # modern vim
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      # enableFishIntegration = true; readonly - always enabled
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    # A modern replacement for ‘ls’ - succressor to exa
    # useful in bash/zsh prompt, not in nushell.
    eza = {
      enable = true;
      # if zsh integration is enabled, I get unwanted aliases which are difficult to override
      enableZshIntegration = false;
      git = false;
      icons = false;
    };

    fzf = {
      enable = true;
      defaultCommand = "fd --type file --color=always --hidden --exclude=.git";
      defaultOptions = [ "--ansi" ];
      fileWidgetCommand = "fd --type file --color=always --hidden --exclude=.git";
      changeDirWidgetCommand = "fd --type directory --color=always --hidden --exclude=.git";
    };
    
    kitty = {
      enable = true;
      # settings = {
      #   shell = "/etc/profiles/per-user/todd.burnside/bin/fish --login --interactive";
      # };
      shellIntegration = {
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
      font = {
        name = "JetBrainsMono Nerd Font Mono";
        size = 13;
      };
    };

    mcfly = {
      enable = true;
      enableZshIntegration = true;
      fuzzySearchFactor = 3;
      fzf.enable = true;
      keyScheme = "vim";
    };

    tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };

    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        scalameta.metals
        esbenp.prettier-vscode
	stylelint.vscode-stylelint
	eamodio.gitlens
	github.copilot
      ];
    };

    zsh = {
      enable = true;
      sessionVariables = {
        SBT_OPTS = "-Xmx16G";
      };
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    # skim provides a single executable: sk.
    # Basically anywhere you would want to use grep, try sk instead.
    # skim = {
    #   enable = true;
    #   enableBashIntegration = true;
    # };
  };
}
