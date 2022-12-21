{ config, pkgs, ... }:
let
    userName = "adeeb";
    homeDir = "/home/adeeb";
in
{
    imports = [
        ../../modules/dev.nix
        ../../modules/theme.nix
        ../../modules/user-configs/shells.nix
        ../../modules/user-configs/aliases.nix
    ];
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
    services.flameshot.settings = {
        General = {
            savePath = "~/Pictures/ScreenShots";
            savePathFixed = true;
            showStartupLaunchMessage = false;
        };
    };

    # Automation for user

    home.file.".local/bin" = {
        source = ../../modules/user-configs/dot-local/bin;
        recursive = true;
    };

    systemd.user.sessionVariables = {
        # not the best option but idk any other way
        PATH = "/run/current-system/sw/bin:/etc/profiles/per-user/${userName}/bin:$PATH";
    };
    systemd.user.services = {
        battery-notifier = {
            Unit = {
                Description = "Service that notifies when battery is low";
                After = "network.target";
            };
            Service = {
                WorkingDirectory = "%h";
                ExecStart = "%h/.local/bin/notifyBatteryStatus.sh";
                Type = "oneshot";
            };
            Install = {
                WantedBy = [ "default.target" ];
            };
        };
        delete-trash = {
            Unit = {
                Description = "Service that empties trash older than 14 days";
                After = "network.target";
            };
            Service = {
                WorkingDirectory = "%h";
                ExecStart = "/usr/bin/env trash-empty 14 -f";
                Type = "oneshot";
            };
            Install = {
                WantedBy = [ "default.target" ];
            };
        };
    };
    systemd.user.timers = {
        battery-notifier = {
            Unit = {
                Description = "Timer for battery notifier service";
            };
            Timer = {
                OnBootSec = "0min";
                OnCalendar = "*-*-* *:*:00";
            };
            Install = {
                WantedBy = [ "timers.target" ];
            };
        };
        delete-trash = {
            Unit = {
                Description = "Timer for delete trash service";
            };
            Timer = {
                OnBootSec = "0min";
                OnCalendar = "*-*-* 00:00:00";
            };
            Install = {
                WantedBy = [ "timers.target" ];
            };
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
