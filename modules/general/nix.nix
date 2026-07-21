{
  flake.modules.nixos.base = { pkgs, lib, ... }: {
    nix = {
      package = pkgs.nixVersions.latest;
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;
        warn-dirty = false;
      };
      gc = {
        automatic = true;
        options = "--delete-older-than 7d";
        dates = "weekly";
      };
    };
    nixpkgs.config.allowUnfree = true;
  };

  flake.modules.darwin.base = { pkgs, lib, ... }: {
    nix = {
      package = pkgs.nixVersions.latest;
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;
        warn-dirty = false;
      };
      gc = {
        automatic = true;
        options = "--delete-older-than 7d";
        interval = { Weekday = 0; Hour = 0; Minute = 0; };
      };
    };
    nixpkgs.config.allowUnfree = true;
  };
}
