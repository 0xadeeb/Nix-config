{
  flake.modules.homeManager.dev = { config, lib, pkgs, ... }:
let
  cfg = config.host.dev.languages;
in
{
  config = lib.mkMerge [
    (lib.mkIf cfg.c-cpp {
      home.packages = with pkgs; [ clang-tools cmake gcc gdb ];
    })
    
    (lib.mkIf cfg.docker {
      home.packages = with pkgs; [ dockerfile-language-server-nodejs ];
    })
    
    (lib.mkIf cfg.go {
      home.packages = with pkgs; [ gopls go ];
    })
    
    (lib.mkIf cfg.haskell {
      home.packages = with pkgs; [ ghc haskell-language-server stack ];
    })
    
    (lib.mkIf cfg.js-ts {
      home.packages = with pkgs; [
        nodejs
        yarn
        typescript
        typescript-language-server
        vscode-json-languageserver
      ];
    })
    
    (lib.mkIf cfg.node {
      home.packages = with pkgs; [
        nodejs
        bun
      ];
    })

    (lib.mkIf cfg.python {
      home.packages = with pkgs; [
        pyright
        python3
        python3Packages.pip
        python3Packages.python-lsp-server
      ];
    })
    
    (lib.mkIf cfg.rust {
      home.packages = with pkgs; [ rustup ];
    })
  ];
};
}
