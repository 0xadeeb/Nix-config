{
  flake.modules.nixos.base = { lib, ... }: {
    options.homebrew = {
      enable = lib.mkEnableOption "homebrew dummy shim";
      casks = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
      brews = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
      taps = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
      onActivation = lib.mkOption {
        type = lib.types.attrs;
        default = {};
      };
    };
  };

  flake.modules.homeManager.base = { lib, ... }: {
    options.homebrew = {
      enable = lib.mkEnableOption "homebrew dummy shim";
      casks = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
      brews = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
      taps = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
      onActivation = lib.mkOption {
        type = lib.types.attrs;
        default = {};
      };
    };
  };
}
