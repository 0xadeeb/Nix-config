{ lib, ... }:

let
  inherit (lib) mkOption types mkEnableOption;

  hostOptions = {
    name = mkOption {
      type = types.str;
      description = "The hostname of the machine.";
    };

    user = {
      name = mkOption {
        type = types.str;
        default = "adeeb";
        description = "The primary user of the machine.";
      };
      email = mkOption {
        type = types.str;
        default = "adeeb@example.com";
        description = "The primary email of the user.";
      };
    };

    state = {
      version = mkOption {
        type = types.str;
        default = "22.11";
        description = "State version for NixOS/Home-Manager.";
      };
      darwin = mkOption {
        type = types.int;
        default = 5;
        description = "State version for nix-darwin.";
      };
    };

    system = mkOption {
      type = types.str;
      description = "System architecture (e.g., x86_64-linux).";
    };

    dev = {
      emacs = {
        enable = mkEnableOption "Doom Emacs";
      };
      languages = {
        python = mkEnableOption "Python development environment";
        rust = mkEnableOption "Rust development environment";
        go = mkEnableOption "Go development environment";
        node = mkEnableOption "Node/Bun development environment";
        c-cpp = mkEnableOption "C/C++ development";
        docker = mkEnableOption "Docker development";
        haskell = mkEnableOption "Haskell development";
        js-ts = mkEnableOption "JS/TS development";
      };
    };
  };
in
{
  flake.modules.nixos.base = {
    options.host = hostOptions;
  };
  flake.modules.darwin.base = {
    options.host = hostOptions;
  };
  flake.modules.homeManager.base = {
    options.host = hostOptions;
  };
}
