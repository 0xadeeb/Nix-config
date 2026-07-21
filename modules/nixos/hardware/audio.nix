{
  flake.modules.nixos.audio = { ... }:
{
  # Pulseaudio is obsolete, GNOME uses pipewire by default
  # We just explicitly disable it and enable pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
};
}
