# Desktop (jcpc) home-manager config.
#
# Imports shared home base, theme (kitty colours, waybar, GTK, cursor, zellij),
# and Hyprland window manager. Theme options come from sharedModules in the
# NixOS config; this file just sets host-specific values.
{ config, pkgs, ... }:

{
  imports = [
    ../../modules/shared/home.nix
    ../../modules/theme/home-theme.nix
    ../../modules/hypr/hyprland.nix
  ];

  # ── Host-specific theme settings ────────────────────────────────────────
  theme.wallpaper = "/home/jc/flake/hosts/desktop/background.jpg";
  theme.monitor = "DP-1";

  # Desktop-only packages
  home.packages = with pkgs; [
  ];

  programs.zsh.shellAliases = {
    home = "vim ~/flake/hosts/desktop/home.nix";
    config = "vim ~/flake/hosts/desktop/default.nix";
  };
}