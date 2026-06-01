{ config, pkgs, ... }:

{
  imports = [
    ../../modules/shared/home.nix
    ./theme.nix
  ];

  home.file = {
    ".sqls.yaml" = {
      text = ''
        datasources:
          - alias: hermes
            connections:
              - driver: postgresql
                dataSourceName: "host=localhost port=5432 user=hermes dbname=hermes password=password"
      '';
    };
  };

  home.packages = with pkgs; [
    # Additional desktop-specific packages
  ];

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

  gtk.gtk3.extraConfig.gtk-application-prefer-dark-theme = true;

  gtk = {
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
