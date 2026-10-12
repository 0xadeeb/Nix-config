{ config, inputs, ... }:

let
  host = {
    name = "thinkpad-omarchy";
    user.name = "adeeb";
    user.email = "adeeb.hs1@gmail.com";
    state = {
      version = "24.11";
    };
    system = "x86_64-linux";
    dev = {
      emacs.enable = false;
      languages = {
        c-cpp = true;
        js-ts = true;
        node = true;
        python = true;
        rust = true;
      };
    };
  };
in
{
  flake.homeConfigurations.${host.name} = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      inherit (host) system;
      config.allowUnfree = true;
    };
    extraSpecialArgs = { inherit inputs; };
    modules = with config.flake.modules.homeManager; [
      base
      core
      dev
      personal-common
      personal-linux
      coding-agent

      ({ pkgs, ... }: {
        inherit host;
        targets.genericLinux.enable = true;
      })
    ];
  };
}
