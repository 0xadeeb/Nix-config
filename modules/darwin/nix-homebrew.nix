{
  flake.modules.darwin.nix-homebrew = { config, inputs, ... }: {
    imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];
    
    nix-homebrew = {
      enable = true;
      autoMigrate = true;
      enableRosetta = true;
      user = config.host.user.name;
      mutableTaps = false;
      taps = {
        "homebrew/homebrew-core" = inputs.homebrew-core;
        "homebrew/homebrew-cask" = inputs.homebrew-cask;
      };
    };
  };
}
