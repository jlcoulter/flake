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
    rustup
  ];

  home.sessionVariables = {
    # macOS: Xcode SDK libraries aren't on the default library path,
    # so Rust needs LIBRARY_PATH to find libc and other system libs.
    # The $(xcrun ...) is evaluated at shell startup time.
    LIBRARY_PATH = "/usr/lib:$(xcrun --show-sdk-path)/usr/lib";

    # rustup installs cargo/rustc to ~/.cargo/bin
    PATH = "$HOME/.cargo/bin:$PATH";
  };

  programs.zsh.shellAliases = {
    config = "vim ~/flake/hosts/macbook/default.nix";
  };
}
