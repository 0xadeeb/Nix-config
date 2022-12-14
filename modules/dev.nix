{ config, lib, pkgs, ... }:

let
  rust-analyzer-fixed = pkgs.symlinkJoin {
  name = "rust-analyzer";
  paths = [ pkgs.rust-analyzer ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/rust-analyzer \
      --set CARGO_TARGET_DIR target/rust-analyzer
  '';
};
in
{
  home.packages = with pkgs; [
    # C/C++
    clang-tools

    # Haskell
    stack
    haskell-language-server

    # Python
    python310Packages.python-lsp-server

    # Rust
    rust-analyzer-fixed
    rustup
  ];
}
