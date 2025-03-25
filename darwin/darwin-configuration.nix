{ pkgs, user, ... }:

{
    imports = [];

    users.users.${user} = {
        home = "/Users/${user}";
        shell = pkgs.zsh;
    };
    
    programs.zsh.enable = true;

    environment.systemPackages = with pkgs; [
        eza
        htop
        mkalias
        tmux
    ];

    # Use nix flakes
    nix = {
      package = pkgs.nix;
      gc = {
        automatic = true;
        interval.Day = 7;
        options = "--delete-older-than 7d";
      };
      extraOptions = "experimental-features = nix-command flakes";
    };

    homebrew = {
        enable = true;
        onActivation = {
            upgrade = false;
            autoUpdate = false;
            cleanup = "zap";
        };
        brews = [
          "powerlevel10k"
          "zsh-autosuggestions"
          "zsh-syntax-highlighting"
        ];
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
