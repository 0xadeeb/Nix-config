{ lib, attrs, nixpkgs, home-manager, doom-emacs, user, location, zoxideOverlay, ... }:

let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
            zoxideOverlay
        ];
    };

    lib = nixpkgs.lib;
in
{
    HpPavilion = lib.nixosSystem {
        inherit system;
        specialArgs = {
            inherit attrs user location;
        };
        modules = [
            {
                nixpkgs.config.allowUnfree = true;
                nixpkgs.overlays = [ zoxideOverlay ];
            }
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

    devsys = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
            ./devsystem
            ./devsystem/home.nix
        ];
    };
}
