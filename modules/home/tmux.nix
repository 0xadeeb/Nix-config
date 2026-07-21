{
  flake.modules.homeManager.tmux = { config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      # Source dotfiles tmux.conf if it exists
      if-shell "test -f ${../../dotfiles/dot-tmux.conf}" "source-file ${../../dotfiles/dot-tmux.conf}"
    '';
  };
};
}
