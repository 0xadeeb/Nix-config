{    lib, pkgs, attrs, user, location, ... }:

{
    # Use nix flakes
    nix = {
        package = pkgs.nixFlakes;
        extraOptions = "experimental-features = nix-command flakes";
    };

}
