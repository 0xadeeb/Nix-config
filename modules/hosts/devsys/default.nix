{ config, inputs, ... }:

let
  host = {
    name = "devsys";
    user.name = "devuser";
    user.email = "dev@example.com";
    state = {
      version = "22.05";
    };
    system = "x86_64-linux";
    dev = {
      emacs.enable = false;
      languages = {
        python = true;
      };
    };
  };
in
{
  flake.homeConfigurations.${host.name} = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${host.system};
    extraSpecialArgs = { inherit inputs; };
    modules = with config.flake.modules.homeManager; [
      base
      shell
      dev
      core
      git
      
      ({ pkgs, ... }: {
        inherit host;
        targets.genericLinux.enable = true;
        
        # This is a standalone build, so it's not embedded in an OS config.
        # Home Manager state version needs to be set.
      })
    ];
  };
}
