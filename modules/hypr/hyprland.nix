# Hyprland home-manager module.
#
# Reads theme options from config.theme (provided by modules/theme/everforest.nix
# at the NixOS level and consumed here as a home-manager option).
# The hyprpaper service is handled by modules/theme/home-theme.nix.
{
  pkgs,
  lib,
  config,
  ...
}:

let
  palette = config.theme.palette;
  cursor-theme = config.theme.cursor-theme;

  # Strip leading '#' from hex colour codes for Hyprland Lua rgba/hex formats
  stripHash = s: builtins.substring 1 (builtins.stringLength s - 1) s;

  # Read the Lua config and substitute theme placeholders
  luaConfig =
    builtins.replaceStrings
      [
        "@mainMod@"
        "@cursor_theme@"
        "@cursor_size@"
        "@border_active@"
        "@border_blue@"
        "@border_inactive@"
        "@bg0@"
        "@wallpaper@"
        "@monitor@"
      ]
      [
        "SUPER"
        cursor-theme.name
        (toString cursor-theme.size)
        "rgba(${stripHash palette.green}ee)"
        "rgba(${stripHash palette.blue}ee)"
        "rgba(${stripHash palette.bg4}aa)"
        (stripHash palette.bg0)
        config.theme.wallpaper
        config.theme.monitor
      ]
      (builtins.readFile ./hyprland.lua);

in
{
  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";
      settings = { };

      extraConfig = luaConfig;
    };

    # Prevent Hyprland from auto-generating a stub hyprland.conf that would
    # shadow our hyprland.lua. An empty .conf ensures Hyprland finds the .lua
    # config on startup (Lua takes priority over hyprlang when both exist).
    xdg.configFile."hypr/hyprland.conf" = {
      text = "# Managed by home-manager. Config is in hyprland.lua\n";
      force = true;
    };
  };
}