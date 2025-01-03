{ pkgs, config, user, ... }:

{
    imports = [];

    users.users.${user} = {
        home = "/Users/${user}";
        shell = pkgs.zsh;
    };
    
    programs.zsh.enable = true;

    environment.systemPackages = with pkgs; [
        htop
        mkalias
        starship
        tmux
    ];

    homebrew = {
        enable = true;
        onActivation = {
            upgrade = false;
            autoUpdate = false;
            cleanup = "zap";
        };
        casks = [
            "iterm2"
            "vlc"
            "font-jetbrains-mono"
            "font-jetbrains-mono-nerd-font"
        ];
        masApps = {
            "Elmedia" = 1044549675;
        };
    };
    system.activationScripts.applications.text = let
    env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = "/Applications";
    };
    in
    pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
    '';
    services.nix-daemon.enable = true;
    system.stateVersion = 5;
}