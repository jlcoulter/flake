{ config, pkgs, ... }:

{
  imports = [
    ../../modules/shared/home.nix
    ./theme.nix
  ];

  home.file = { };

  home.packages = with pkgs; [
    # Additional desktop-specific packages
  ];

  programs.kitty = {
    enable = true;

    font = {
      name = "Fira Code";
      size = 16;
    };

    settings = {
      background_opacity = "1.0";
      background_blur = 1;
      disable_ligatures = "never";

      bold_font = "Fira Code Bold";
      italic_font = "Fira Code Italic";
      bold_italic_font = "Fira Code Bold Italic";

      background = "#282828";
      foreground = "#D4BE98";
      selection_background = "#D4BE98";
      selection_foreground = "#282828";
      cursor = "#A89984";

      color0 = "#282828";
      color1 = "#EA6962";
      color2 = "#A9B665";
      color3 = "#D8A657";
      color4 = "#7DAEA3";
      color5 = "#D3869B";
      color6 = "#89B482";
      color7 = "#D4BE98";

      color8 = "#7C6F64";
      color9 = "#EA6962";
      color10 = "#A9B665";
      color11 = "#D8A657";
      color12 = "#7DAEA3";
      color13 = "#D3869B";
      color14 = "#89B482";
      color15 = "#DDC7A1";
    };
  };

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3;
    config = {
      startup = [
        {
          command = "picom -b";
          always = true;
          notification = false;
        }
        {
          command = "xrandr --setmonitor 'Virtual-Left' 1280/232x2160/392+0+0 DP-1";
          notification = false;
        }
        {
          command = "xrandr --setmonitor 'Virtual-CenterMain' 2560/465x2160/392+1280+0 DP-1";
          notification = false;
        }
        {
          command = "xrandr --setmonitor 'Virtual-Right' 1280/232x2160/392+3840+0 DP-1";
          notification = false;
        }
      ];
      modifier = "Mod4";
      workspaceOutputAssign = [
        {
          workspace = "1";
          output = "Virtual-Left";
        }
        {
          workspace = "2";
          output = "Virtual-CenterMain";
        }
        {
          workspace = "3";
          output = "Virtual-Right";
        }
      ];
      gaps = {
        inner = 10;
        outer = 5;
      };
    };
  };

  programs = {
    yazi = {
      settings = {
        opener = {
          edit = [
            {
              run = "$EDITOR %s";
              block = true;
              desc = "Neovim";
            }
          ];
        };

        open = {
          rules = [
            {
              name = "*";
              use = [ "edit" ];
            }
          ];
        };
      };
    };

    i3status-rust = {
      enable = true;
      bars = {
        top = {
          blocks = [
            {
              block = "time";
              interval = 60;
              format = "$timestamp.datetime('%a %d/%m %k:%M %p')";
            }
          ];
        };
      };
    };

    home-manager.enable = true;
    rofi = {
      enable = true;
      extraConfig = {
        font = "Fira Code Mono 16";
        configPath = "./../../modules/rofi/config.rasi";
      };
    };

    git = {
      enable = true;
      settings = {
        user.name = "jlcoulter";
        user.email = "coulter.l.jack@gmail.com";
        aliases = {
          pu = "push";
          co = "checkout";
          cm = "commit";
        };
      };
    };

    zsh = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch --flake ~/flake/#default";
        flake = "cd ~/flake && vim ~/flake/flake.nix";
        home = "vim ~/flake/hosts/home/home.nix";
        config = "vim ~/flake/hosts/home/configuration.nix";
        pynix = "nix-shell ~/code/shell.nix";
        nvimconfig = "vim ~/.config/nvim/init.vim";
        clobber = "git add . && git commit -m \"$(date)\" && git push";
      };
    };
  };

  gtk = {
    enable = true;
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
