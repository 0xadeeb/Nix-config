{
  flake.modules.nixos.gnome = { ... }:
{
  services.xserver.displayManager.defaultSession = "gnome";
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
};
}
