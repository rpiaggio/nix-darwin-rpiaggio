{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    localVariables = { 
      MCFLY_RESULTS = 25;
    };
    history = {
      ignoreAllDups = true;
    };
    prezto = {
      enable = true;
      pmodules = [
        "environment"
        "terminal"
        "editor"
        "history"
        "directory"
        "spectrum"
        # "utility"
        "completion"
        "syntax-highlighting"
        "history-substring-search"
        "autosuggestions"
        "prompt"
      ];
      editor = {
        dotExpansion = true;
        keymap = "vi";
      };
      prompt = {
        pwdLength = "short";
        theme = "powerlevel10k";
      };
    };
    # The eza aliases and p10k config could also be loaded as modules, as in the commented `plugins` below,
    # however this results in them being added to the path.
    # For a discussion of these alternatives for loading config into zshell, see
    # https://discourse.nixos.org/t/zsh-zplug-powerlevel10k-zshrc-is-readonly/30333
    initExtra = ''
      # eza aliases. Run 'lh' for help.
      # Note: if eza zsh integration is enabled, it overwrites some of the aliases.
      [[ ! -f ${./eza-aliases.zsh} ]] || source ${./eza-aliases.zsh}

      # This is for using the powerlevel10k theme.
      # Run `p10k configure` and then copy the .p10k.zsh file to ../p10k-config and remove
      # the leading dot.
      [[ ! -f ${./p10k.zsh} ]] || source ${./p10k.zsh}

      # Token for fontawesome - not managed in nix 
      # Need to do this a better way...
      [[ ! -f /Users/raul.piaggio/fontawesome.zsh ]] || source /Users/raul.piaggio/fontawesome.zsh
    '';
    # plugins = [
    #   {
    #     name = "powerlevel10k-config";
    #     src = ../p10k-config;
    #     file = "p10k.zsh";
    #   }
    #   # {
    #   #     name = "eza-aliases";
    #   #     src = ../eza-aliases;
    #   #     file = "eza-aliases.zsh";
    #   # }
    # ];
  };

  programs.bash.enable = true; # see note on other shells below

  home.shellAliases = {
    kj = "killall -9 java";
    
    # ripgrep aliases
    ss = "rg -t scala";
    sj = "rg -t java";
    sjs = "rt -t scala -t java";
    bss = "batgrep -t scala";
    man = "batman";

    top = "btm -b";
    batz = "bat ~/.zshrc";
    oldbatz = "bat ~/old-laptop/.zshrc";

    # View/Delete local tracking branches no longer on remote
    viewLocal = "git for-each-ref --format='%(if:equals=[gone])%(upstream:track)%(then)%(refname:short)%(end)' refs/heads";
    pruneLocal = "git branch -D \$(git for-each-ref --format='%(if:equals=[gone])%(upstream:track)%(then)%(refname:short)%(end)' refs/heads)";

    # useful for working in the odb and other projects where autoformatting is not used by everyone.
    scalafmtAssumeUnchanged = "git update-index --assume-unchanged .scalafmt.conf";
    scalafmtNoAssumeUnchanged = "git update-index --no-assume-unchanged .scalafmt.conf";

    # avoid duplicate instances in dock
    code="open -b com.microsoft.VSCode";

    # git
    grc = "git rebase --continue"
    gra = "git rebase --abort"
  };

}
