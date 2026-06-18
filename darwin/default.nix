{lib, attrs, nixpkgs, home-manager, nix-homebrew, darwin, mac-app-util, user, location, herdr, zoxideOverlay, ... }:

let
    system = "aarch64-darwin";
    pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
            zoxideOverlay
        ];
    };
in
{
    MacBookMChip = darwin.lib.darwinSystem {
        inherit system;
        specialArgs = {
            inherit attrs user location;
        };
        modules = [
            {
                nixpkgs.config.allowUnfree = true;
                nixpkgs.overlays = [ zoxideOverlay ];
            }
            nix-homebrew.darwinModules.nix-homebrew
            # ./mac-mchip 
            ./darwin-configuration.nix
            mac-app-util.darwinModules.default
            home-manager.darwinModules.home-manager
            {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {
                    herdrPackage = herdr.packages.${system}.default;
                };
                home-manager.sharedModules = [
                    mac-app-util.homeManagerModules.default
                ];
                home-manager.users.${user} = {
                    imports = [
                        ./home.nix
                    ];
                };
            }
        ];
    };
}
