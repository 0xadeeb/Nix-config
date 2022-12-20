{ config, lib, pkgs, ... }:

{
  imports = [
    ./starship.nix
  ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    history.extended = true;

    oh-my-zsh = {
      enable = true;
      custom = "$HOME/.oh-my-zsh/custom";
      plugins = [
        "git"
        "colored-man-pages"
        # "zsh-autosuggestions "
        # "zsh-syntax-highlighting "
        "zsh-vi-mode"
      ];
    };

    initExtra = ''
      ZVM_VI_INSERT_ESCAPE_BINDKEY=fj
      ZVM_KEYTIMEOUT=0.15

      function up () {
        local d=""
        local limit="$1"

        # Default to limit of 1
        if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
          limit=1
        fi

        for ((i=1;i<=limit;i++)); do
          d="../$d"
        done

        # perform cd. Show error if cd fails
        if ! cd "$d"; then
          echo "Couldn't go up $limit dirs.";
        fi
      }
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
}
