{ pkgs, lib, config, ... }:

let
  # ═══════════════════════════════════════════════════════════════════════
  #  EVERFOREST COLOUR PALETTE (dark, medium contrast)
  #  Edit these values to change colours across the entire system.
  # ═══════════════════════════════════════════════════════════════════════

  palette = {
    # Core backgrounds
    bg0        = "#2b3339";   # darkest background
    bg1        = "#323c41";   # darker background
    bg2        = "#373e45";   # background
    bg3        = "#3d4452";   # lighter background
    bg4        = "#445259";   # lightest background
    bg5        = "#505d66";   # visual selection

    # Core foregrounds
    fg         = "#d3c6aa";   # main foreground
    fg1        = "#9da9a0";   # muted foreground (statusline, comments)

    # Accent colours
    red        = "#e67e80";
    orange     = "#e69875";
    yellow     = "#dbbc7f";
    green      = "#a7c080";
    cyan       = "#83c092";
    blue       = "#7fbbb3";
    purple     = "#d699b6";
    aqua       = "#83c092";

    # Semantic (aliases for convenience)
    bg         = palette.bg0;
    fg_dim     = palette.fg1;
    cursor     = palette.fg;
    selection  = palette.bg5;

    # Derived for Hyprland borders (strip '#' for Lua rgba/hex formats)
    border_active   = palette.green;
    border_inactive = palette.bg4;
  };

  # GTK theme
  gtk-theme = {
    package = pkgs.everforest-gtk-theme;
    name    = "everforest";
  };

  # Icon theme (use Papirus with everforest folder colours)
  icon-theme = {
    package = pkgs.papirus-icon-theme;
    name    = "Papirus-Dark";
  };

  # Cursor theme
  cursor-theme = {
    package = pkgs.everforest-cursors;
    name    = "everforest-cursors";
    size    = 24;
  };

in
{
  # ── Expose palette and cursor theme for other modules (e.g. hyprland) ──
  theme.palette = palette;
  theme.cursor-theme = cursor-theme;

  # ── Kitty terminal colours ──────────────────────────────────────────────
  programs.kitty.settings = {
    background            = palette.bg0;
    foreground            = palette.fg;
    selection_background  = palette.bg5;
    selection_foreground  = palette.fg;
    cursor                = palette.fg;

    # Normal colours (colour0–colour7)
    color0  = palette.bg0;      # black
    color1  = palette.red;
    color2  = palette.green;
    color3  = palette.yellow;
    color4  = palette.blue;
    color5  = palette.purple;
    color6  = palette.aqua;
    color7  = palette.fg;

    # Bright colours (colour8–colour15)
    color8  = palette.bg3;
    color9  = palette.red;
    color10 = palette.green;
    color11 = palette.yellow;
    color12 = palette.blue;
    color13 = palette.purple;
    color14 = palette.aqua;
    color15 = palette.fg;
  };

  # ── Home-manager cursor ─────────────────────────────────────────────────
  home.pointerCursor = {
    gtk.enable  = true;
    x11.enable  = true;
    package     = cursor-theme.package;
    name        = cursor-theme.name;
    size        = cursor-theme.size;
  };

  # ── GTK theme ────────────────────────────────────────────────────────────
  gtk = {
    enable      = true;
    colorScheme = "dark";
    theme = gtk-theme;
    iconTheme = icon-theme;
    cursorTheme = cursor-theme;
    gtk4.theme = null;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  };
}