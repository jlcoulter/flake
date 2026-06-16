{ config, pkgs, ... }:

{
  imports = [
    ../../modules/shared/home.nix
    ./theme.nix
    ../../modules/hypr/hyprland.nix
  ];

  home.packages = with pkgs; [
    # Additional desktop-specific packages
  ];

  programs = {
    zsh = {
      enable = true;
      shellAliases = {
        home = "vim ~/flake/hosts/home/home.nix";
        config = "vim ~/flake/hosts/home/configuration.nix";
      };
    };
  };
}