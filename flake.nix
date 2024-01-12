{
  description = "flake for nixnebula";

  inputs = {
    nixpkgs = {
      url = "nixpkgs/nixos-23.11";
    };

    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nixpkgs, rust-overlay, nixpkgs-unstable, home-manager, ... }:
    let
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config = {
            allowUnfree = true;
            permittedInsecurePackages = [
              # used by obsidian
              "electron-25.9.0"
            ];
          };
        };
      };
    in
    {
      nixosConfigurations = {
        nixnebula = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            # Overlays-module makes "pkgs.unstable" available in configuration.nix
            ({ config, pkgs, ... }: {
              nixpkgs.overlays = [ overlay-unstable rust-overlay.overlays.default ];
              environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
            })
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit nixpkgs; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.eric = import ./home.eric.nix;
            }
          ];
        };
      };
    };
}
