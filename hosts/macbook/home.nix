# MacBook (macOS) home-manager config.
#
# Uses shared home base + everforest theme for Kitty colours and Zellij.
# Waybar and hyprpaper are Linux-only so they're guarded by isLinux in
# modules/theme/home-theme.nix and won't activate on macOS.
{ config, pkgs, ... }:

{
  imports = [
    ../../modules/shared/home.nix
    ../../modules/theme/everforest.nix
    ../../modules/theme/home-theme.nix
  ];

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # macOS-specific packages go here
  ];

  programs.zsh.shellAliases = {
    config = "vim ~/flake/hosts/macbook/default.nix";
  };
}