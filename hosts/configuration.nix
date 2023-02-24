# Edit this configuration file to define what should be installed on
# your system.    Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    imports =
        [
        ];

    # Nix Packages collection configuration
    nixpkgs.config = {
        allowBroken = false;
        allowUnfree = true;
    };

    networking.hostName = "HpPavilion"; # Define your hostname.
    # Pick only one of the below networking options.
    # networking.wireless.enable = true;    # Enables wireless support via wpa_supplicant.
    networking.networkmanager.enable = true;    # Easiest to use and most distros use this by default.

    # Set your time zone.
    time.timeZone = "Asia/Kolkata";

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_GB.UTF-8";
    # console = {
    #     earlySetup = true;
    #     packages = with pkgs; [ terminus_font ];
    #     font = "ter-v32n";
    #     # useXkbConfig = true; # use xkbOptions in tty.
    # };

    services = {
        # Enable the X11 windowing system.
        xserver = {
            enable = true;
            layout = "us";
            windowManager = {
                xmonad = {
                    enable = true;
                    enableContribAndExtras = true;
                    extraPackages = haskellPackages: [
                        haskellPackages.dbus
                        haskellPackages.xmonad
                        haskellPackages.xmonad-dbus
                        haskellPackages.monad-logger
                        haskellPackages.List
                    ];
                };
            };
            displayManager = {
                defaultSession = "gnome";
                gdm.enable = true;
                startx.enable = true;
                # lightdm = {
                #     enable = true;
                #     greeters.enso = {
                #         enable = true;
                #         blur = true;
                #     };
                # };
            };
            desktopManager.gnome.enable = true;
        };
        gvfs.enable = true;
        udisks2.enable = true;
        devmon.enable = true;
    };


    # Power manager
    powerManagement.enable = true;
    services.auto-cpufreq.enable = true;
    services.upower = {
        enable = true;
        usePercentageForPolicy = true;
        percentageLow = 20;
        percentageCritical = 10;
        percentageAction = 10;
        criticalPowerAction = "HybridSleep";
    };

    # Enable bluetooth
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;

    # Enable CUPS to print documents.
    # services.printing.enable = true;

    # Enable sound.
    sound.enable = true;
    hardware.pulseaudio.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    services.xserver.libinput.enable = true;

    # Virtualization
    virtualisation = {
        libvirtd.enable = true;
        virtualbox.host = {
            enable = true;
            enableExtensionPack = true;
        };
        docker = {
            enable = true;
            storageDriver = "btrfs";
        };
    };

    # Security
    security.polkit.enable = true;
    security.polkit.extraConfig = ''
        polkit.addRule(function(action, subject) {
        var YES = polkit.Result.YES;
        var permission = {
            // only required for udisks1:
            "org.freedesktop.udisks.filesystem-mount": YES,
            "org.freedesktop.udisks.filesystem-mount-system-internal": YES,
            "org.freedesktop.udisks.luks-unlock": YES,
            "org.freedesktop.udisks.drive-eject": YES,
            "org.freedesktop.udisks.drive-detach": YES,
            // only required for udisks2:
            "org.freedesktop.udisks2.filesystem-mount": YES,
            "org.freedesktop.udisks2.filesystem-mount-system": YES,
            "org.freedesktop.udisks2.encrypted-unlock": YES,
            "org.freedesktop.udisks2.encrypted-unlock-system": YES,
            "org.freedesktop.udisks2.eject-media": YES,
            "org.freedesktop.udisks2.power-off-drive": YES,
            // required for udisks2 if using udiskie from another seat (e.g. systemd):
            "org.freedesktop.udisks2.filesystem-mount-other-seat": YES,
            "org.freedesktop.udisks2.encrypted-unlock-other-seat": YES,
            "org.freedesktop.udisks2.eject-media-other-seat": YES,
            "org.freedesktop.udisks2.power-off-drive-other-seat": YES
        };
        if (subject.isInGroup("users")) {
            return permission[action.id];
        }
        });
        /* Allow users in mykvm group to manage the libvirt daemon without authentication */
        polkit.addRule(function(action, subject) {
            if (action.id == "org.libvirt.unix.manage" &&
                subject.isInGroup("mykvm")) {
                    return polkit.Result.YES;
            }
        });
    '';

    # Define a user account.
    users.users.root = {
        isSystemUser = true;
        shell = pkgs.zsh;
    };
    users.users.adeeb = {
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" "libvirtd" "qemu-libvirtd" ];
        shell = pkgs.zsh;
        initialPassword = "password";
    };

    # Splash screen
    boot.plymouth.enable = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    programs.vim.defaultEditor = true;
    environment.systemPackages = with pkgs; [
        brightnessctl
        dbus
        dunst
        git
        glib
        gparted
        gnome.zenity
        gnome.gnome-tweaks
        gnumake
        lxqt.lxqt-policykit
        killall
        kitty
        libtool
        lsb-release
        networkmanagerapplet
        ntfs3g
        pkgconfig
        shared-mime-info
        starship
        udiskie
        unzip
        wget
        xfce.xfce4-power-manager
        gnome.gnome-power-manager
        gnome.gnome-session
        xorg.xmodmap
    ];

    # Use nix flakes
    nix = {
        package = pkgs.nixFlakes;
        extraOptions = "experimental-features = nix-command flakes";
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #     enable = true;
    #     enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    # system.copySystemConfiguration = true;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "22.11"; # Did you read the comment?

}

