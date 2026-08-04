{
  flake.modules.nixos.libvirt = { ... }:
{
  virtualisation.libvirtd.enable = true;
};
}
