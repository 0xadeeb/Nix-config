{
  flake.modules.homeManager.work-linux = { pkgs, ... }: {
    home.packages = with pkgs; [
      obsidian
      drawio
    ];
  };
}
