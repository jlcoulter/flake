# Everforest dark theme — palette and theme packages.
#
# This is a HOME-MANAGER module. It defines `theme.*` options within the
# home-manager module system so that other HM modules (like home-theme.nix
# and hyprland.nix) can read config.theme.palette etc.
#
# For NixOS hosts, import this via home-manager.sharedModules in the host
# config. For darwin, import it directly in the darwin HM modules list.
#
# The palette is a plain attrset (no self-references) to avoid infinite
# recursion. Semantic aliases (bg, fg_dim, etc.) are derived with `let ... in`.
{ pkgs, lib, ... }:

let
  # ── Everforest Dark (medium contrast) ──────────────────────────────────
  everforest = {
    # Core backgrounds
    bg0 = "#2b3339";
    bg1 = "#323c41";
    bg2 = "#373e45";
    bg3 = "#3d4452";
    bg4 = "#445259";
    bg5 = "#505d66";   # visual selection

    # Core foregrounds
    fg  = "#d3c6aa";
    fg1 = "#9da9a0";   # muted (statusline, comments)

    # Accent colours
    red    = "#e67e80";
    orange = "#e69875";
    yellow = "#dbbc7f";
    green  = "#a7c080";
    cyan   = "#83c092";
    blue   = "#7fbbb3";
    purple = "#d699b6";
    aqua   = "#83c092";
  };

in
{
  options.theme = with lib; {
    palette = mkOption {
      type = types.attrs;
      default = everforest;
      description = "Colour palette attrset used across the system.";
    };

    gtk-theme = mkOption {
      type = types.attrs;
      default = {
        package = pkgs.everforest-gtk-theme;
        name    = "everforest";
      };
      description = "GTK theme attrset: { package, name }.";
    };

    icon-theme = mkOption {
      type = types.attrs;
      default = {
        package = pkgs.papirus-icon-theme;
        name    = "Papirus-Dark";
      };
      description = "Icon theme attrset: { package, name }.";
    };

    cursor-theme = mkOption {
      type = types.attrs;
      default = {
        package = pkgs.everforest-cursors;
        name    = "everforest-cursors";
        size    = 24;
      };
      description = "Cursor theme attrset: { package, name, size }.";
    };

    wallpaper = mkOption {
      type = types.str;
      default = "";
      description = "Absolute path to the wallpaper image.";
    };

    monitor = mkOption {
      type = types.str;
      default = "";
      description = "Monitor name for hyprpaper (e.g. \"DP-1\").";
    };
  };
}