{
    description = "Nixos config using flakes";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11"; # Nix packages
        home-manager = {         # Home Package Management
            url = github:nix-community/home-manager;
            inputs.nixpkgs.follows = "nixpkgs";
        };
        doom-emacs = {           # Doom emacs
            url = github:nix-community/nix-doom-emacs;
        };
    };

    outputs = { self, nixpkgs, home-manager, doom-emacs, ... } @ attrs:
    let
        user = "adeeb";
        location = "$HOME/.setup";
    in
    {
        nixosConfigurations = (
            import ./hosts {
                inherit (nixpkgs) lib;
                inherit attrs nixpkgs home-manager doom-emacs user location;
            }
        );
    };

}
