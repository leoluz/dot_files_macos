{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    go2one = {
      url = "github:leoluz/go2one";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Source-only input for its Claude Code skills; bumped by hms-update.
    superpowers = {
      url = "github:obra/superpowers";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, go2one, superpowers, ... }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
	config.allowUnfree = true;
      };
    in {
      homeConfigurations."leoluz" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = { inherit go2one superpowers system; };
      };
    };
}
