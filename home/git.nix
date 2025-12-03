{
  lib,
  ...
}: {
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    rm -f ~/.gitconfig
  '';

  programs = {
    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        features = "side-by-side";
      };
    };

    git = {
      enable = true;
      lfs.enable = true;

      ignores = [
        ".bloop"
        ".metals"
        ".vscode"
        ".jvmopts"
      ];

      settings = {
        user = { # TODO replace with your own name & email
          name = "Raúl Piaggio";
          email = "rpiaggio@gemini.edu";
        };

        extraConfig = {
          init.defaultBranch = "main";
          push.autoSetupRemote = true;
          core.editor = "nvim";
        };

        aliases = {
          # common aliases
          br = "branch";
          co = "checkout";
          st = "status";
          ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
          ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
          cm = "commit -m";
          ca = "commit -am";
          dc = "diff --cached";
          amend = "commit --amend -m";

          # aliases for submodule
          update = "submodule update --init --recursive";
          foreach = "submodule foreach";
        };
      };
    };
  };
}
