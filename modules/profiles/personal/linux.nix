{
  flake.modules.homeManager.personal-linux = { pkgs, ... }: {
    home.packages = with pkgs; [
      brave
      firefox
      libreoffice
      telegram-desktop
    ];
  };
}
