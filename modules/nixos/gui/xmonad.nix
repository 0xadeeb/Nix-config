{
  flake.modules.nixos.xmonad = { ... }:
{
  services.xserver = {
    enable = true;
    layout = "us";
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        haskellPackages.dbus
        haskellPackages.xmonad
        haskellPackages.xmonad-dbus
        haskellPackages.monad-logger
        haskellPackages.List
      ];
    };
  };
};
}
