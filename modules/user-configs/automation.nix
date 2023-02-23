{ config, lib, pkgs, ... }:

{
    home.file.".local/bin" = {
        source = ./dot-local/bin;
        recursive = true;
    };

    systemd.user.sessionVariables = {
        # not the best option but idk any other way
      PATH = "/run/current-system/sw/bin:/etc/profiles/per-user/adeeb/bin:$PATH";
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
}
