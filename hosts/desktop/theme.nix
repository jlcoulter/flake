{ pkgs, lib, config, ... }:

let
  # ═══════════════════════════════════════════════════════════════════════
  #  EVERFOREST COLOUR PALETTE (dark, medium contrast)
  #  Edit these values to change colours across the entire system.
  # ═══════════════════════════════════════════════════════════════════════

  palette = {
    # Core backgrounds
    bg0        = "#2b3339";   # darkest background
    bg1        = "#323c41";   # darker background
    bg2        = "#373e45";   # background
    bg3        = "#3d4452";   # lighter background
    bg4        = "#445259";   # lightest background
    bg5        = "#505d66";   # visual selection

    # Core foregrounds
    fg         = "#d3c6aa";   # main foreground
    fg1        = "#9da9a0";   # muted foreground (statusline, comments)

    # Accent colours
    red        = "#e67e80";
    orange     = "#e69875";
    yellow     = "#dbbc7f";
    green      = "#a7c080";
    cyan       = "#83c092";
    blue       = "#7fbbb3";
    purple     = "#d699b6";
    aqua       = "#83c092";

    # Semantic (aliases for convenience)
    bg         = palette.bg0;
    fg_dim     = palette.fg1;
    cursor     = palette.fg;
    selection  = palette.bg5;

    # Derived for Hyprland borders (strip '#' for Lua rgba/hex formats)
    border_active   = palette.green;
    border_inactive = palette.bg4;
  };

  # GTK theme
  gtk-theme = {
    package = pkgs.everforest-gtk-theme;
    name    = "everforest";
  };

  # Icon theme (use Papirus with everforest folder colours)
  icon-theme = {
    package = pkgs.papirus-icon-theme;
    name    = "Papirus-Dark";
  };

  # Cursor theme
  cursor-theme = {
    package = pkgs.everforest-cursors;
    name    = "everforest-cursors";
    size    = 24;
  };

in
{
  # ── Expose palette and cursor theme for other modules (e.g. hyprland) ──
  theme.palette = palette;
  theme.cursor-theme = cursor-theme;

  # ── Kitty terminal colours ──────────────────────────────────────────────
  programs.kitty.settings = {
    background            = palette.bg0;
    foreground            = palette.fg;
    selection_background  = palette.bg5;
    selection_foreground  = palette.fg;
    cursor                = palette.fg;

    # Normal colours (colour0–colour7)
    color0  = palette.bg0;      # black
    color1  = palette.red;
    color2  = palette.green;
    color3  = palette.yellow;
    color4  = palette.blue;
    color5  = palette.purple;
    color6  = palette.aqua;
    color7  = palette.fg;

    # Bright colours (colour8–colour15)
    color8  = palette.bg3;
    color9  = palette.red;
    color10 = palette.green;    # bright green keeps the real everforest green for terminal content
    color11 = palette.yellow;
    color12 = palette.blue;
    color13 = palette.purple;
    color14 = palette.aqua;
    color15 = palette.fg;
  };

  # ── Home-manager cursor ─────────────────────────────────────────────────
  home.pointerCursor = {
    gtk.enable  = true;
    x11.enable  = true;
    package     = cursor-theme.package;
    name        = cursor-theme.name;
    size        = cursor-theme.size;
  };

  # ── GTK theme ────────────────────────────────────────────────────────────
  gtk = {
    enable      = true;
    colorScheme = "dark";
    theme = gtk-theme;
    iconTheme = icon-theme;
    cursorTheme = cursor-theme;
    gtk4.theme = null;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  # ── Waybar ──────────────────────────────────────────────────────────────
  programs.waybar = {
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
          active = "";
          urgent = "";
          default = "";
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
        format = " {temperatureC}°C";
        critical-threshold = 80;
        format-critical = " {temperatureC}°C";
      };

      battery = {
        format = "{icon} {capacity}%";
        format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        format-charging = "󰂄 {capacity}%";
      };

      tray = { spacing = 8; };
    };

    style = ''
      /* ── Everforest Dark palette (sourced from theme.nix) ──────────── */
      @define-color bg0        ${palette.bg0};
      @define-color bg1        ${palette.bg1};
      @define-color bg2        ${palette.bg2};
      @define-color bg3        ${palette.bg3};
      @define-color bg4        ${palette.bg4};
      @define-color bg5        ${palette.bg5};
      @define-color fg         ${palette.fg};
      @define-color fg1        ${palette.fg1};
      @define-color red        ${palette.red};
      @define-color orange     ${palette.orange};
      @define-color yellow     ${palette.yellow};
      @define-color green      ${palette.green};
      @define-color cyan       ${palette.cyan};
      @define-color blue       ${palette.blue};
      @define-color purple     ${palette.purple};
      @define-color aqua       ${palette.aqua};

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

  # ── Zellij theme ────────────────────────────────────────────────────────
  programs.zellij = {
    settings.theme = "everforest-dark";
  };
}