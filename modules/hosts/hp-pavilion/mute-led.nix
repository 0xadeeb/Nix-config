{
  flake.modules.nixos.mute-led = { ... }:
{
  environment.etc."modprobe.d/mute-led.conf" = {
    source = ./mute-led.conf;
  };
};
}
