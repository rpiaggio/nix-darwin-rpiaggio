{ pkgs, ... }: {

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  # 
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas 
    masApps = {
      Bitwarden = 1352778147;
      HiddenBar = 1452453066;
      NetWorkerLite = 1228738830;
    #  TimeOut = 402592703;
      WeatherBug = 1059074180;
    };

    # taps = [
    #   "homebrew/cask-fonts"
    #   "homebrew/services"
    #   "homebrew/cask-versions"
    # ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
    #   "wget" # download tool
    #   "curl" # no not install curl via nixpkgs, it's not working well on macOS!
    #   "aria2" # download tool
    #   "httpie" # http client
    ];


    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      "alt-tab"
      "arc"
      # "bitwarden"
      "bluesnooze"
      "docker"
      "flux"
      "foxitreader"
      # "gitkraken"
      "hammerspoon"
      # "hiddenbar"
      # "httpie"
      "jumpcut"
      "kap"
      "karabiner-elements"
      # "mimestream"
      "monitorcontrol"
      # "obsidian"
      "scroll-reverser"
      {
        name = "stretchly";
	args = { no_quarantine = true; };
      }

      # # IM & audio & remote desktop & meeting
      # "telegram"
      # "discord"

      # "anki"
      # "iina" # video player
      # "raycast" # (HotKey: alt/option + space)search, caculate and run scripts(with many plugins)
      # "stats" # beautiful system monitor
      # "eudic" # 欧路词典

      # # Development
      # "insomnia" # REST client
      # "wireshark" # network analyzer
    ];
  };
}
