{
  flake.modules.homeManager.personal-common = { pkgs, ... }: {
    home.packages = with pkgs; [
      mpv
      zathura
    ];
  };
}
