{ pkgs, user, ... }:

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
    services.nix-daemon.enable = true;
    system.stateVersion = 5;
}
