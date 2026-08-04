{ config, inputs, ... }:

let
  host = {
    name = "HpPavilion";
    user.name = "adeeb";
    user.email = "adeeb@example.com";
    state = {
      version = "22.11";
      darwin = 5;
    };
    system = "x86_64-linux";
    dev = {
      emacs = { enable = true; };
      languages = {
        python = true;
        c-cpp = true;
      };
    };
  };
in
{
  flake.nixosConfigurations.${host.name} = inputs.nixpkgs.lib.nixosSystem {
    system = host.system;
    specialArgs = { inherit inputs; };
    modules = with config.flake.modules.nixos; [
      base
      xmonad
      gnome
      power
      bluetooth
      audio
      touchpad
      docker
      libvirt
      virtualbox
      polkit
      boot
      packages
      mute-led
      
      hp-pavilion-hardware

      # Machine specific inline config
      ({ pkgs, ... }: {
        inherit host;
        networking.hostName = host.name;
        time.timeZone = "Asia/Kolkata";
        i18n.defaultLocale = "en_GB.UTF-8";
        system.stateVersion = host.state.version;

        home-manager.users.${host.user.name} = {
          imports = with config.flake.modules.homeManager; [
            base
            shell
            dev
            core
            git
            doom
            tmux
            linux-automation
            personal-common
            personal-linux
          ];
        };
      })
    ];
  };
}
