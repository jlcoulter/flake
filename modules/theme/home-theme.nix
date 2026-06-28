# Home-Manager theme module — applies the everforest palette to all apps.
#
# Import this in any home.nix that wants themed Kitty, Waybar, GTK, cursor, Zellij.
# It reads from config.theme.palette / config.theme.cursor-theme etc. which are
# defined by modules/theme/everforest.nix (imported at the NixOS or darwin level).
#
# Usage in a home.nix:
#   imports = [ ../../modules/theme/home-theme.nix ];
#
# No extra config needed — the module reads config.theme automatically.
{ config, pkgs, lib, ... }:

let
  p = config.theme.palette;
  ct = config.theme.cursor-theme;
in
{
  # ── Kitty terminal colours ─────────────────────────────────────────────
  programs.kitty.settings = {
    background            = p.bg0;
    foreground            = p.fg;
    selection_background  = p.bg5;
    selection_foreground  = p.fg;
    cursor                = p.fg;

    # Normal colours
    color0  = p.bg0;
    color1  = p.red;
    color2  = p.green;
    color3  = p.yellow;
    color4  = p.blue;
    color5  = p.purple;
    color6  = p.aqua;
    color7  = p.fg;

    # Bright colours
    color8  = p.bg3;
    color9  = p.red;
    color10 = p.green;
    color11 = p.yellow;
    color12 = p.blue;
    color13 = p.purple;
    color14 = p.aqua;
    color15 = p.fg;
  };

  # ── Cursor ──────────────────────────────────────────────────────────────
  home.pointerCursor = {
    gtk.enable  = true;
    x11.enable  = true;
    package     = ct.package;
    name        = ct.name;
    size        = ct.size;
  };

  # ── GTK theme ───────────────────────────────────────────────────────────
  gtk = {
    enable      = true;
    colorScheme = "dark";
    theme       = config.theme.gtk-theme;
    iconTheme   = config.theme.icon-theme;
    cursorTheme = ct;
    gtk4.theme  = null;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  # ── Zellij theme ────────────────────────────────────────────────────────
  programs.zellij.settings.theme = "everforest-dark";

  # ── Waybar (Linux only — guarded by isLinux) ────────────────────────────
  programs.waybar = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 34;
      spacing = 4;
      margin-top = 4;
      margin-bottom = 0;
      margin-left = 8;
      margin-right = 8;

      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "hyprland/window" ];
      modules-right = [
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "temperature"
        "battery"
        "clock"
        "tray"
      ];

      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          active = "";
          urgent = "";
          default = "";
        };
        persistent-workspaces = { "*" = 5; };
      };

      "hyprland/window" = {
        format = "{title}";
        max-length = 50;
        rewrite = {
          "(.*) — Mozilla Firefox" = "󰈹 $1";
          "(.*) - Visual Studio Code" = "󰨞 $1";
          "(.*) - NVIM" = "nvim $1";
        };
      };

      clock = {
        format = "󰥔 {:%H:%M}";
        format-alt = "󰃭 {:%a %d %b %Y}";
        tooltip-format = "<tt>{calendar}</tt>";
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "󰝟 muted";
        format-icons = { default = "󰕾"; };
        on-click = "pavucontrol";
      };

      network = {
        format-wifi = "󰤨 {essid}";
        format-ethernet = "󰈀 wired";
        format-disconnected = "󰤭 offline";
        tooltip-format-wifi = "Signal: {signalStrength}%";
      };

      cpu = { format = "󰻠 {usage}%"; };
      memory = { format = "󰍛 {}%"; };
      temperature = {
        format = " {temperatureC}°C";
        critical-threshold = 80;
        format-critical = " {temperatureC}°C";
      };

      battery = {
        format = "{icon} {capacity}%";
        format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        format-charging = "󰂄 {capacity}%";
      };

      tray = { spacing = 8; };
    };

    style = ''
      /* ── Everforest Dark palette ─────────────────────────────────── */
      @define-color bg0        ${p.bg0};
      @define-color bg1        ${p.bg1};
      @define-color bg2        ${p.bg2};
      @define-color bg3        ${p.bg3};
      @define-color bg4        ${p.bg4};
      @define-color bg5        ${p.bg5};
      @define-color fg         ${p.fg};
      @define-color fg1        ${p.fg1};
      @define-color red        ${p.red};
      @define-color orange     ${p.orange};
      @define-color yellow     ${p.yellow};
      @define-color green      ${p.green};
      @define-color cyan       ${p.cyan};
      @define-color blue       ${p.blue};
      @define-color purple     ${p.purple};
      @define-color aqua       ${p.aqua};

      /* ── Global ────────────────────────────────────────────────────── */
      * {
        border: none;
        border-radius: 0;
        font-family: "Fira Code", "Symbols Nerd Font Mono", "Noto Sans CJK SC";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: @bg0;
        color: @fg;
      }

      /* ── Workspaces ───────────────────────────────────────────────── */
      #workspaces button {
        padding: 0 8px;
        color: @fg1;
        background: transparent;
      }
      #workspaces button.active {
        color: @green;
      }
      #workspaces button.urgent {
        color: @red;
      }
      #workspaces button:hover {
        color: @fg;
        background: @bg2;
      }

      /* ── Modules ──────────────────────────────────────────────────── */
      #window {
        color: @fg;
        padding: 0 12px;
      }

      #clock,
      #pulseaudio,
      #network,
      #cpu,
      #memory,
      #temperature,
      #battery,
      #tray {
        padding: 0 10px;
        margin: 0 2px;
        color: @fg;
        background: @bg1;
        border-radius: 4px;
      }

      #clock { color: @yellow; }
      #pulseaudio { color: @blue; }
      #network { color: @cyan; }
      #cpu { color: @green; }
      #memory { color: @purple; }
      #temperature { color: @orange; }
      #temperature.critical { color: @red; }
      #battery { color: @green; }
      #battery.warning:not(.charging) { color: @orange; }
      #battery.critical:not(.charging) { color: @red; }
      #tray { color: @fg1; }

      tooltip {
        background: @bg1;
        color: @fg;
        border: 1px solid @bg3;
      }
    '';
  };

  # ── Hyprpaper (Linux only) ─────────────────────────────────────────────
  services.hyprpaper = lib.mkIf pkgs.stdenv.isLinux {
    enable = config.theme.wallpaper != "";
    settings = lib.mkIf (config.theme.wallpaper != "") {
      splash = false;
      preload = [ config.theme.wallpaper ];
      wallpaper = [{ monitor = ""; path = config.theme.wallpaper; }];
    };
  };
}