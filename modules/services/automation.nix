{
  flake.modules.homeManager.linux-automation = { config, lib, pkgs, ... }:
{
    home.file.".local/bin" = {
        source = ../../dotfiles/dot-local/bin;
        recursive = true;
    };

    systemd.user.sessionVariables = {
      PATH = "/run/current-system/sw/bin:${config.home.profileDirectory}/bin:$PATH";
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
                ExecStart = "${pkgs.trash-cli}/bin/trash-empty 14 -f";
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
};
}
