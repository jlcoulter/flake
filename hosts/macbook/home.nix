{ config, pkgs, ... }:

{
  imports = [
    ../../modules/shared/home.nix
  ];

  home.file = { };

  home.packages = with pkgs; [
    # macOS specific packages can go here
  ];

  programs = {
    home-manager.enable = true;
  };
}

