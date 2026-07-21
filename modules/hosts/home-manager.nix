{ inputs, ... }:

{
  flake.modules.nixos.base = { config, ... }: {
    imports = [ 
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      # backupCommand = "trash"; # requires trash-cli
      extraSpecialArgs = {
        inherit inputs;
        inherit (config) host;
        osConfig = config;
      };
      users.${config.host.user.name} = {
        host = config.host;
        home.stateVersion = config.host.state.version;
        programs.home-manager.enable = true;
      };
    };
  };

  flake.modules.darwin.base = { config, ... }: {
    imports = [
      inputs.home-manager.darwinModules.home-manager
      inputs.mac-app-util.darwinModules.default
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {
        inherit inputs;
        inherit (config) host;
        osConfig = config;
      };
      users.${config.host.user.name} = {
        host = config.host;
        home.stateVersion = config.host.state.version;
      };
    };
  };

  flake.modules.homeManager.base = { config, pkgs, lib, ... }:
  let
    host = config.host;
  in {
    nix.package = lib.mkDefault pkgs.nixVersions.latest;
    home = {
      username = host.user.name;
      homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${host.user.name}" else "/home/${host.user.name}";
      packages = [ pkgs.home-manager ];
      stateVersion = host.state.version;
    };
  };
}
