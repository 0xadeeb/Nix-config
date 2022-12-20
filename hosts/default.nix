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
    "HpPavilion" = lib.nixosSystem {
        specialArgs = {
            inherit pkgs attrs user location;
        };
        modules = [
            ./hp-pavilion
            ./configuration.nix
            home-manager.nixosModules.home-manager {        # Home-Manager module that is used.
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${user} = import ./hp-pavilion/home.nix;
            }
        ];
    };
}
