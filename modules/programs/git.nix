{
  flake.modules.homeManager.git = { config, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = config.host.user.email;
        name = config.host.user.name;
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
};
}
