{ config, pkgs, ... }:

{
  imports = [
    ../../modules/shared/home.nix
    ./theme.nix
  ];

  home.packages = with pkgs; [
    # Additional desktop-specific packages
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  programs = {
    zsh = {
      enable = true;
      shellAliases = {
        update = "sudo nixos-rebuild switch --flake ~/flake/#default";
        flake = "cd ~/flake && vim ~/flake/flake.nix";
        home = "vim ~/flake/hosts/home/home.nix";
        config = "vim ~/flake/hosts/home/configuration.nix";
        clobber = "git add . && git commit -m \"$(date)\" && git push";
      };
    };
  };

  gtk.gtk3.extraConfig.gtk-application-prefer-dark-theme = true;

  gtk = {
    gtk4.theme = null;
    enable = true;
    colorScheme = "dark";
    theme = {
      package = pkgs.gruvbox-material-gtk-theme;
      name = "Gruvbox-Material-Dark-Medium";
    };
    iconTheme = {
      package = pkgs.gruvbox-dark-icons-gtk;
      name = "gruvbox-dark";
    };
    cursorTheme = {
      package = pkgs.capitaine-cursors-themed;
      name = "capitaine-cursors-gruvbox";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        "HYPRCURSOR_SIZE,24"
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "XCURSOR_SIZE,24"
      ];
    };
    extraConfig = builtins.readFile ../../modules/hypr/hyprland.conf;
  };
}
