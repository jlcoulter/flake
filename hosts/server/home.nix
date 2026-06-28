# Server home-manager config.
#
# Minimal: shared home base (kitty, zsh, git, zellij, nvim) — no desktop,
# no theme, no Hyprland. Servers don't need a GUI.
{ pkgs, ... }:

{
  imports = [
    ../../modules/shared/home.nix
  ];

  home.packages = with pkgs; [
    htop
    curl
    wget
    rsync
    unzip
  ];

  programs.zsh.shellAliases = {
    config = "vim ~/flake/hosts/server/default.nix";
  };
}