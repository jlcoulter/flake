{ pkgs, lib, ... }: {
  imports = [];

  home = {
    username = lib.mkDefault (if pkgs.stdenv.isDarwin then "jlcoulter" else "jc");
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/jlcoulter" else "/home/jc";
    stateVersion = "24.11";
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