{
  flake.modules.nixos.packages = { pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    brightnessctl
    dbus
    dunst
    git
    glib
    gparted
    zenity
    gnome-tweaks
    gnumake
    lxqt.lxqt-policykit
    killall
    kitty
    libtool
    lsb-release
    networkmanagerapplet
    ntfs3g
    pkg-config
    shared-mime-info
    starship
    udiskie
    unzip
    wget
    xfce.xfce4-power-manager
    gnome-power-manager
    gnome-session
    xorg.xmodmap
  ];

  programs.vim.enable = true;
  programs.vim.defaultEditor = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;
};
}
