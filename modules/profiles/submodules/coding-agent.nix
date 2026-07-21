{
  flake.modules.homeManager.coding-agent = { pkgs, inputs, ... }: {
    home.packages = with pkgs; [
      claude-code
      github-copilot-cli
      mermaid-cli
      # The herdr flake doesn't expose codex out of the box in nixpkgs, 
      # but we can get herdr from inputs
      inputs.herdr.packages.${pkgs.system}.default
    ];
  };
}
