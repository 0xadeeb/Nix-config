{ config, inputs, ... }:

let
  host = {
    name = "MacBookMChip";
    user.name = "ahadisee";
    user.email = "ahadisee@example.com";
    state = {
      version = "22.05";
      darwin = 5;
    };
    system = "aarch64-darwin";
    dev = {
      emacs.enable = false;
      languages = {
        python = true;
        rust = true;
        go = true;
        node = true;
      };
    };
  };
in
{
  flake.darwinConfigurations.MacBookMChip = inputs.darwin.lib.darwinSystem {
    system = host.system;
    specialArgs = { inherit inputs; };
    modules = with config.flake.modules.darwin; [
      base
      nix-homebrew
      homebrew
      
      # Inline machine configuration
      ({ pkgs, ... }: {
        inherit host;
        
        # System-level Darwin config
        environment.systemPackages = [ pkgs.mkalias ];
        programs.zsh.enable = true;
        system.primaryUser = host.user.name;
        system.stateVersion = host.state.darwin;

        # Home Manager user assembly
        home-manager.users.${host.user.name} = {
          imports = with config.flake.modules.homeManager; [
            base
            shell
            dev
            core
            git
            
            # The cross-platform profiles (Mac uses both work and personal)
            work
            personal
          ];
        };
      })
    ];
  };
}
