{
  flake.modules.nixos.touchpad = { ... }:
{
  services.xserver.libinput.enable = true;
};
}
