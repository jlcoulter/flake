{ config, pkgs, ... }:

{
  imports = [
    ./theme.nix
  ];
  home = {

    username = "jc";
    homeDirectory = "/home/jc";
    stateVersion = "24.11";
  };

  home.file = {
    #"config.ron".source = ../modules/leftwm;
  };

  home.packages = with pkgs; [
    fira-code
    fira-code-symbols
  ];

  programs.kitty = {
    enable = true;

    font = {
      name = "Fira Code";
      size = 16;
    };

    settings = {
      # Window settings
      background_opacity = "1.0";
      background_blur = 1;

      # Ligature support explicitly on
      disable_ligatures = "never";

      # Fonts
      bold_font = "Fira Code Bold";
      italic_font = "Fira Code Italic";
      bold_italic_font = "Fira Code Bold Italic";

      # Gruvbox Material Main Colors
      background = "#282828"; # bg0
      foreground = "#D4BE98"; # fg0
      selection_background = "#D4BE98"; # fg0
      selection_foreground = "#282828"; # bg0
      cursor = "#A89984"; # grey2

      # Normal Colors (Gruvbox Material Palette)
      color0 = "#282828"; # bg0 (Black)
      color1 = "#EA6962"; # red
      color2 = "#A9B665"; # green
      color3 = "#D8A657"; # yellow
      color4 = "#7DAEA3"; # blue
      color5 = "#D3869B"; # purple / magenta (using bright variant for visibility)
      color6 = "#89B482"; # aqua / cyan
      color7 = "#D4BE98"; # fg0 (White)

      # Bright Colors
      color8 = "#7C6F64"; # grey0 (Bright Black)
      color9 = "#EA6962"; # red
      color10 = "#A9B665"; # green
      color11 = "#D8A657"; # yellow
      color12 = "#7DAEA3"; # blue
      color13 = "#D3869B"; # purple
      color14 = "#89B482"; # aqua
      color15 = "#DDC7A1"; # fg1 (Bright White)
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

    neovim = {
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
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
    zellij = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autocd = true;
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
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
        ];
        theme = "agnoster";
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

  home.sessionVariables = {
    EDITOR = "vim";
  };

}
