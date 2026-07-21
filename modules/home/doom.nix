{
  flake.modules.homeManager.doom = { config, lib, pkgs, inputs, ... }:
let
  cfg = config.host.dev.emacs;
in
{
  imports = [ inputs.doom-emacs.hmModule ];
  
  config = lib.mkIf cfg.enable {
    programs.doom-emacs = {
      enable = true;
      doomPrivateDir = ../../dotfiles/dot-doom.d;
    };
    
    # Dependencies required by Doom Emacs
    home.packages = with pkgs; [
      ripgrep
      coreutils
      fd
      clang
      cmake
    ];
  };
};
}
