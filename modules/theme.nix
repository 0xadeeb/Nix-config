{ config, lib, pkgs, ... }:

{
    # Gtk theme
    gtk = {
        enable = true;
        font = {
            name = "Public Sans";
            size = 11;
        };
        cursorTheme.name = "Dracula-cursors";
        iconTheme = {
            package = pkgs.papirus-icon-theme;
            name = "Papirus-Dark";
        };
        theme = {
            package = pkgs.dracula-theme;
            name = "Dracula";
        };
    };

    home.pointerCursor = {
        gtk.enable = true;
        package = pkgs.dracula-theme;
        name = "Dracula-cursors";
    };

    home.packages = with pkgs; [
        # catppuccin-gtk
        dconf
        # dracula-theme
        lxappearance
    ];
}
