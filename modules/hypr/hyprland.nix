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
        "rgba(${stripHash palette.border_active}ee)"
        "rgba(${stripHash palette.blue}ee)"
        "rgba(${stripHash palette.border_inactive}aa)"
        (stripHash palette.bg0)
        config.theme.wallpaper
        config.theme.monitor
      ]
      (builtins.readFile ./hyprland.lua);

in
{
  options.theme = with lib; {
    palette = mkOption {
      type = types.attrs;
      default = { };
      description = "Colour palette to use across the system.";
    };
    cursor-theme = mkOption {
      type = types.attrs;
      default = { };
      description = "Cursor theme attrset with package, name, size.";
    };
    wallpaper = mkOption {
      type = types.str;
      default = "";
      description = "Absolute path to the wallpaper image for hyprpaper.";
    };
    monitor = mkOption {
      type = types.str;
      default = "";
      description = "Monitor name for hyprpaper (e.g. \"DP-1\").";
    };
  };

  config = {
    services.hyprpaper = {
      enable = true;
      settings = {
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
