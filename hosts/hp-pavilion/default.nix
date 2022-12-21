{    lib, pkgs, attrs, user, location, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    # Use the systemd-boot EFI boot loader.
    boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        supportedFilesystems = [ "btrfs" ];
        loader = {
            efi = {
                canTouchEfiVariables = true;
                # efiSysMountPoint = "/boot/EFI";
            };
            grub = {
                enable = true;
                devices = ["nodev"];
                efiSupport = true;
                useOSProber = true;
                configurationLimit = 10;
            };
        };
    };

    # Touchpad settings
    services.xserver.libinput.touchpad = {
        naturalScrolling = true;
        clickMethod = "clickfinger";
        tapping = true;
        accelSpeed = "0.60";
        disableWhileTyping = true;
    };

    # System config files
    # boot.extraModprobeConfig = "options snd-hda-intel model=alc295-hp-x360";
    environment.etc = {
        "modprobe.d/mute-led.conf"    = {
            source = ../../modules/system-configs/laptop/mute-led.conf;
            mode = "0444";
        };
    };

}
