{
  description = "flake for nixnebula";

  inputs = {
    nixpkgs = {
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

  outputs = inputs@{ self, nixpkgs, rust-overlay, home-manager, ... }: {
    nixosConfigurations = {
      nixnebula = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ({pkgs, ...}: {
            nixpkgs.overlays = [rust-overlay.overlays.default];
            environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
          })
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.eric = import ./home.eric.nix;
          }
        ];
      };
    };
  };
}
