{ config, pkgs, ... }:

{
    imports = [
        ../../modules/dev.nix
        ../../modules/theme.nix
        ../../modules/user-configs/shells.nix
        ../../modules/user-configs/aliases.nix
    ];
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home.username = "adeeb";
    home.homeDirectory = "/home/adeeb";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "22.11";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # programs.zsh = {
    #     enable = true;
    #     oh-my-zsh = {
    #         enable = true;
    #     };
    # };

    # home.file.".zshrc" = {
    #     source = ../../modules/user-configs/dot-zshrc;
    # };

    # Bluetooth
    services.blueman-applet.enable = true;

    # Screenshots
    services.flameshot.settings = {
        General = {
            savePath = "~/Pictures/ScreenShots";
            savePathFixed = true;
            showStartupLaunchMessage = false;
        };
    };

    # Application settings
    dconf.settings = {
        "org/nemo/preferences" = {
            click-policy = "single";
        };
    };

    home.packages = with pkgs; [
        alacritty
        alttab
        bat
        betterlockscreen
        bluez
        brave
        cinnamon.nemo
        cmake
        conky
        emacs
        fd
        feh
        flameshot
        exa
        gcc
        gdb
        ghc
        gnome.dconf-editor
        gvfs
        htop
        libreoffice
        libnotify
        lm_sensors
        mpv
        neofetch
        parcellite
        picom-jonaburg
        polybar
        procs
        python39
        ranger
        ripgrep
        rofi
        snapper
        snapper-gui
        stow
        taffybar
        tdesktop
        trash-cli
        victor-mono
        wmctrl
        yad
        zathura
        zoxide
    ];

}
