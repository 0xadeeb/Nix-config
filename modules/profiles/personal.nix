{
  flake.modules.homeManager.personal = { config, pkgs, lib, ... }: {
    home.packages = with pkgs; [
      mpv
      zathura
    ] ++ lib.optionals pkgs.stdenv.isLinux [
      brave
      firefox
      libreoffice
      telegram-desktop
    ];

    # Casks for macOS
    homebrew.casks = [
      "vlc"
      "brave-browser"
      "firefox"
      "telegram"
    ];
  };
}
