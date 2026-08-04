{
  flake.modules.darwin.homebrew = { config, ... }: {
    homebrew = {
      enable = true;
      taps = builtins.attrNames config.nix-homebrew.taps;
      onActivation = {
        upgrade = false;
        autoUpdate = false;
        cleanup = "none";
      };
      
      # Base CLI brews used everywhere on Mac
      brews = [
        "iproute2mac"
        "powerlevel10k"
        "zsh-autosuggestions"
        "zsh-syntax-highlighting"
        "mas"
      ];
      
      # Base casks used everywhere on Mac
      casks = [
        "font-jetbrains-mono"
        "font-jetbrains-mono-nerd-font"
        "iterm2"
        "markedit"
        "zed"
      ];
    };
  };
}
