{ pkgs, user, ... }:

{
    imports = [];

    users.users.${user} = {
        home = "/Users/${user}";
        shell = pkgs.zsh;
    };
    
    programs.zsh.enable = true;

    environment.systemPackages = with pkgs; [
        # Keep only truly system-wide packages here
        mkalias
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

    # Set a fixed primary user for system-wide homebrew management
    # This should be your main admin user
    system.primaryUser = user;

    system.stateVersion = 5;
}
