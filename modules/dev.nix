{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # C/C++
    clang-tools

    # Docker
    nodePackages.dockerfile-language-server-nodejs

    # Go
    gopls

    # Haskell
    stack
    haskell-language-server

    # JS + TS
    nodejs
    yarn
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-json-languageserver

    # Python
    python310Packages.python-lsp-server

    # Rust
    rust-analyzer
    rustup
  ];
}
