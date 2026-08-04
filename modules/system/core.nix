{
  flake.modules.homeManager.core = { pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim
    ripgrep
    fzf
    fd
    htop
    eza
    bat
    zoxide
    wget
    gh
    direnv
    tmux
  ];
};
}
