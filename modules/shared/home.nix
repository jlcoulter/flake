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
    nerd-fonts.symbols-only
    fastfetch
    yazi
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };
}
