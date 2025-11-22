{
  config,
  pkgs,
  ...
}: let
  rootPath = ../.;
in {
  imports = [
    ./theme.nix
  ];

  home.username = "jc";
  home.homeDirectory = "/home/jc";
  home.stateVersion = "24.11";

  home.file = {
    #"config.ron".source = ../modules/leftwm;
  };

  programs.git = {
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


  wayland.windowManager.hyprland.systemd.enable = false;

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake ~/flake/#default";
      flake = "vim ~/flake/flake.nix";
      home = "vim ~/flake/hosts/home/home.nix";
      config = "vim ~/flake/hosts/home/configuration.nix";
      pynix = "nix-shell ~/code/shell.nix";
      nvimconfig = "vim ~/.config/nvim/init.vim";
      clobber = "git add . && git commit -m \"$(date)\" && git push";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
      ];
      theme = "agnoster";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
