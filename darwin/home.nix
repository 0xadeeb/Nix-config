{ config, pkgs, ... }:
let
    userName = "ahadisee";
    homeDir = "/Users/ahadisee";
in
{
    home.username = "${userName}";
    home.homeDirectory = "${homeDir}";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "22.05";

    # Extra directories to add to PATH.
    # home.sessionPath = [
    #     "$HOME/.local/bin"
    #     "$HOME/.emacs.d/bin"
    # ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
        fd
        neovim
        ollama
        ripgrep
        zoxide
    ];

}
