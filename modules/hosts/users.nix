{
  flake.modules.nixos.base = { config, ... }: {
    users.users.${config.host.user.name} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "video" "audio" ];
    };
  };

  flake.modules.darwin.base = { config, ... }: {
    users.users.${config.host.user.name} = {
      name = config.host.user.name;
      home = "/Users/${config.host.user.name}";
    };
  };
}
