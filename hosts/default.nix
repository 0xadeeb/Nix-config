{ lib, attrs, nixpkgs, home-manager, user, location, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  laptop = lib.nixosSystem {
    specialArgs = {
      inherit attrs user location;
    };
    modules = [
      ./laptop
      ./configuration.nix
      home-manager.nixosModules.home-manager {    # Home-Manager module that is used.
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user} = import ./laptop/home.nix;
      }
    ];
  };
}
