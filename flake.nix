{
    description = "Nix config using flakes";

    inputs = {
        # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Nix packages
        nixpkgs.url = github:nixos/nixpkgs/nixos-24.05; # Stable Nix Packages

        home-manager = {         # Home Package Management
            url = github:nix-community/home-manager/release-24.05;
            inputs.nixpkgs.follows = "nixpkgs";
        };

        doom-emacs = {           # Doom emacs
            url = github:nix-community/nix-doom-emacs;
        };

        # Neovim
        # nixvim = {
        #     url = "github:nix-community/nixvim";
        #     inputs.nixpkgs.follows = "nixpkgs";
        # };

        # # Neovim
        # nixvim-stable = {
        #     url = "github:nix-community/nixvim/nixos-23.11";
        #     inputs.nixpkgs.follows = "nixpkgs-stable";
        # };

        # MacOS Package Management
        darwin = {
            url = "github:lnl7/nix-darwin/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    };

    outputs = { self, nixpkgs, home-manager, darwin, nix-homebrew, doom-emacs, ... } @ attrs:
    let
        location = "$HOME/.setup";
    in
    {
        nixosConfigurations = (
            import ./hosts {
                inherit (nixpkgs) lib;
                inherit attrs nixpkgs home-manager doom-emacs location;
                user = "adeeb";
            }
        );
        darwinConfigurations = (
            import ./darwin {
                inherit (nixpkgs) lib;
                inherit attrs nixpkgs home-manager darwin nix-homebrew location;
                user = "ahadisee";
            }
        );
    };

}
