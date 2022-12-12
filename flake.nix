{
  description = "Nixos config using flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11"; # Nix packages
    home-manager = {     # Home Package Management
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ attrs:
    let
      user = "adeeb";
      location = "$HOME/.setup";
    in {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit attrs nixpkgs home-manager user location;
        }
      );
    };

}
