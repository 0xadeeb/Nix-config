{lib, attrs, nixpkgs, home-manager, nix-homebrew, darwin, user, location, ... }:

let
    system = "aarch64-darwin";
    pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
    };
in
{
    MacBookMChip = darwin.lib.darwinSystem {
        inherit system;
        specialArgs = {
            inherit pkgs attrs user location;
        };
        modules = [
            # ./mac-mchip 
            ./darwin-configuration.nix
            home-manager.darwinModules.home-manager
            {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${user} = {
                    imports = [
                        ./home.nix
                    ];
                };
            }
        ];
    };
}