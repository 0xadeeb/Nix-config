{ config, ... }: {
  flake.modules.homeManager.work-common = { pkgs, lib, ... }: {
    imports = [
      config.flake.modules.homeManager.coding-agent
    ];

    home.packages = with pkgs; [
      acli
      google-chrome
      ollama
    ];

    # You can override your default email for the work profile
    programs.git.settings.user.email = lib.mkForce "adeeb.work@example.com";
  };
}
