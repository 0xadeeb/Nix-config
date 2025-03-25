{ pkgs, ... }:
let
    userName = "devuser";
    homeDir = "/home/devuser";
    devImports = import ../../modules/dev.nix { 
      inherit pkgs; 
      languages = {
        python = true;
      }; 
    };
in
{
    imports = [
      devImports
    ];
    home.username = "${userName}";
    home.homeDirectory = "${homeDir}";

    home.stateVersion = "22.11";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
      htop
    ];

}
