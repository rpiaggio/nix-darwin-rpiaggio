{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-23.11-darwin";

    # home-manager, used for managing user configuration
    home-manager = {
      # url = "github:nix-community/home-manager/release-23.11";
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs dependencies.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, home-manager, nixpkgs }:
  let
    system = "aarch64-darwin";
    username = "raul.piaggio";
    hostname = "rpiaggio-ml2";
    allowUnfree = true;
    specialArgs = { inherit inputs username hostname allowUnfree; };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#rpiaggio-ml2
    darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [ 
        ./modules/darwin.nix
        ./modules/system.nix
        ./modules/homebrew.nix

        # home manager
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
            users.${username} = import ./home;
          };
          users.users.${username}.home = "/Users/${username}";
        }
      ];
    };

    # for Explore development
    # networking.hosts = {
    #   "127.0.0.1" = ["local.lucuma.xyz"];
    # };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.${hostname}.pkgs;
  };
}
