{ lib, attrs, nixpkgs, home-manager, doom-emacs, user, location, ... }:

let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
    };

    lib = nixpkgs.lib;
in
{
    HpPavilion = lib.nixosSystem {
        inherit system;
        specialArgs = {
            inherit pkgs attrs user location;
        };
        modules = [
            ./hp-pavilion
            ./configuration.nix
            home-manager.nixosModules.home-manager {        # Home-Manager module that is used.
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${user} = {
                    imports = [
                        ./hp-pavilion/home.nix
                        doom-emacs.hmModule
                    ];
                    programs.doom-emacs = {
                        enable = true;
                        doomPrivateDir = ../modules/user-configs/dot-doom.d;
                    };
                };
            }
        ];
    };
}
