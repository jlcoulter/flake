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

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [
        "~/flake/hosts/desktop/background.jpg"
      ];
      wallpaper = [
        {
          monitor = "";
          path = "~/flake/hosts/desktop/background.jpg";
        }
      ];
    };
  };
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
