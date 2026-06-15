{ pkgs, lib, ... }:
{
  imports = [ ];

  home = {
    username = lib.mkDefault (if pkgs.stdenv.isDarwin then "jlcoulter" else "jc");
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/jlcoulter" else "/home/jc";
    stateVersion = "24.11";
  };

  programs = {
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

  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    shellAliases = {
      ll = "ls -l";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
      theme = "agnoster";
    };
  };

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

  programs.neovim = {
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [
    htop
    neovim
    fira-code
    fira-code-symbols
    fastfetch
    yazi
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };
}
