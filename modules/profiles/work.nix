{ config, ... }: {
  flake.modules.homeManager.work = { pkgs, lib, ... }: {
    imports = [
      config.flake.modules.homeManager.coding-agent
    ];

    home.packages = with pkgs; [
      acli
      obsidian
      ollama
      drawio
    ];

    # Casks for macOS (safely ignored on Linux due to shims.nix)
    homebrew.casks = [
      "cloudflare-warp"
    ];
    
    # You can override your default email for the work profile
    programs.git.settings.user.email = lib.mkForce "adeeb.work@example.com";
  };
}
