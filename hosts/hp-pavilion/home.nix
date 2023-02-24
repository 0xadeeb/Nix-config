{ config, pkgs, ... }:
let
    userName = "adeeb";
    homeDir = "/home/adeeb";
in
{
    imports = [
        # ../../modules/dev.nix
        ../../modules/theme.nix
        ../../modules/user-configs/aliases.nix
        ../../modules/user-configs/automation.nix
        ../../modules/user-configs/shells.nix
    ] ;
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
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
    home.stateVersion = "22.11";

    # Extra directories to add to PATH.
    home.sessionPath = [
        "$HOME/.local/bin"
        "$HOME/.emacs.d/bin"
    ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Bluetooth
    services.blueman-applet.enable = true;

    # Screenshots
    services.flameshot.enable = true;
    services.flameshot.settings = {
        General = {
            savePath = "${homeDir}/Pictures/ScreenShots";
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

    # Doom emacs config
    services.emacs.enable = true;

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
        crate2nix
        # emacs
        exa
        fd
        feh
        flameshot
        fira-code
        firefox-bin
        fzf
        gcc
        gdb
        ghc
        gnome.dconf-editor
        gvfs
        htop
        libreoffice
        libnotify
        libvterm
        lm_sensors
        mpv
        neofetch
        parcellite
        picom-jonaburg
        pkgconfig
        polybar
        procs
        python3
        python3Packages.pip
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
