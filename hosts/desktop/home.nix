{ config, pkgs, ... }:

{
  imports = [
    ../../modules/shared/home.nix
    ./theme.nix
  ];

  home.packages = with pkgs; [
    # Additional desktop-specific packages
  ];

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
}
