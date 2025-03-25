# Invoke this file the following way
# imports = [
#   (import <path>/dev.nix { pkgs = pkgs; languages = { python = true; rust = true; }; })
# ];
# The input "languages" is a map of languages to booleans, where the key is the language name
# (from the set languagePackages defined below) and the value is a boolean
# indicating whether the language should be included in the configuration.

{ pkgs, languages, ... }:
let
  languagePackages = with pkgs; {
    # C/C++
    c-cpp = [
      clang-tools
      cmake
      gcc
      gdb
    ];
    # Docker
    docker = [
      nodePackages.dockerfile-language-server-nodejs
    ];
    # Go
    go = [
      gopls
    ];
    # Haskell
    haskell = [
      ghc
      haskell-language-server
      stack
    ];
    # JS + TS
    js-ts = [
      nodejs
      yarn
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.vscode-json-languageserver
    ];
    # Python
    python = [
      python3
      python311Packages.pip
      python311Packages.python-lsp-server
    ];
    # Rust
    rust = [
      rust-analyzer
      rustup
    ];
  };
in
{
  home.packages = builtins.concatLists (
    builtins.attrValues (
      builtins.intersectAttrs languages languagePackages
    )
  );
}
