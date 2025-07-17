{
  description = "Home Manager configuration of Pia";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix-flake = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # outputs = { nixpkgs, home-manager, ... }:
  #   let
  #     system = "x86_64-linux";
  #     pkgs = nixpkgs.legacyPackages.${system};
  #   in {
  #     homeConfigurations."default" = home-manager.lib.homeManagerConfiguration {
  #       inherit pkgs;

  #       modules = [ ./home.nix ];
  #     };
  #   };

  # outputs = inputs: {
  #   homeConfigurations.default = inputs.home-manager.lib.homeManagerConfiguration {
  #     pkgs = import inputs.nixpkgs {
  #       system = "x86_64-linux";
  #       overlays = [
  #         inputs.helix-flake.overlays.default
  #       ];
  #     };

  #     modules = [
  #       ./home.nix
  #     ];
  #   };
  # };


  outputs = { self, nixpkgs, home-manager, helix-flake, ... }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        helix-flake.overlays.default
      ];
    };
  in {
    homeConfigurations.default = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home.nix ];
    };
  };
}
