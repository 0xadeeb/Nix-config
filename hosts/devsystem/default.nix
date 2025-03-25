{    lib, pkgs, attrs, user, location, ... }:

{
    # Run the following command to setup the first time
    # home-manager --extra-experimental-features "nix-command flakes" switch --flake <path>#devsys
    nix = {
        package = pkgs.nixVersions.stable;
        extraOptions = ''
          experimental-features = nix-command
          experimental-features = nix-command flakes
        '';
    };

}
