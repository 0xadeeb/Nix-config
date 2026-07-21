{
  flake.modules.homeManager.shell = { config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history.extended = true;

    oh-my-zsh = {
      enable = true;
      custom = "$HOME/.oh-my-zsh/custom";
      plugins = [
        "git"
        "colored-man-pages"
        "zsh-vi-mode"
      ];
    };
    
    initContent = ''
      # Always starting with insert mode for each command line
      ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
      ZVM_VI_INSERT_ESCAPE_BINDKEY=fj
      ZVM_KEYTIMEOUT=0.15

      function up () {
        local d=""
        local limit="$1"

        if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
          limit=1
        fi

        for ((i=1;i<=limit;i++)); do
          d="../$d"
        done

        if ! cd "$d"; then
          echo "Couldn't go up $limit dirs.";
        fi
      }

      # Source dotfiles zshrc if it exists
      if [ -f ${../../dotfiles/dot-zshrc} ]; then
        source ${../../dotfiles/dot-zshrc}
      fi
    '';
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
};
}
