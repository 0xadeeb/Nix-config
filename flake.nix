{
    description = "Nix config using flakes";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix packages
        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05"; # Stable Nix Packages

        home-manager = {         # Home Package Management (Unstable)
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        home-manager-stable = {  # Home Package Management (Stable)
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs-stable";
        };

        # MacOS Package Management (Unstable)
        darwin = {
            url = "github:lnl7/nix-darwin/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # MacOS Package Management (Stable)
        darwin-stable = {
            url = "github:LnL7/nix-darwin/nix-darwin-25.05";
            inputs.nixpkgs.follows = "nixpkgs-stable";
        };

        # For nix in MacOS
        nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

        mac-app-util.url = "github:hraban/mac-app-util";

        doom-emacs = {           # Doom emacs
            url = "github:nix-community/nix-doom-emacs";
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
    };

    outputs = {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      home-manager-stable,
      darwin,
      darwin-stable,
      nix-homebrew,
      doom-emacs,
      mac-app-util,
      ...
    } @ attrs:
    let
        location = "$HOME/.setup";
    in
    {
        nixosConfigurations = (
            import ./hosts {
                inherit (nixpkgs) lib;
                inherit attrs nixpkgs nixpkgs-stable home-manager home-manager-stable doom-emacs location;
                user = "adeeb";
            }
        );
        darwinConfigurations = (
            import ./darwin {
                inherit (nixpkgs) lib;
                inherit attrs nixpkgs nixpkgs-stable home-manager home-manager-stable darwin darwin-stable nix-homebrew mac-app-util location;
                user = "ahadisee";
            }
        );
        homeConfigurations = (
            import ./hosts {
                inherit (nixpkgs) lib;
                inherit attrs nixpkgs nixpkgs-stable home-manager home-manager-stable doom-emacs location;
                user = "devuser";
            }
        );
    };

}
