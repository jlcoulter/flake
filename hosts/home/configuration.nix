{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/pcloud/pcloud.nix
    ../../modules/bluetooth/bluetooth.nix
    ../../modules/hyprland/hyprland.nix
    ../../modules/virt/virt.nix
    ../../modules/printer/printer.nix
    ../system/system.nix
    ../../modules/nvim/nvf.nix
  ];

  programs.zsh.enable = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs

    # here, NOT in environment.systemPackages
  ];

  nix.settings.trusted-users = ["root" "jc"];

  fonts.packages = with pkgs; [
    jetbrains-mono
  ];

  users.users.jc = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Jack Coulter";
    extraGroups = ["networkmanager" "wheel" "scanner" "lp" "audio"];
    packages = with pkgs; [
      zsh
      neofetch
      prusa-slicer
      freecad
      spotify
      vscode
      neovim
      git
      alacritty
      protonup
      firefox
      teams-for-linux
      zellij
      nixd
      gopls
      bash-language-server
      xfce.thunar
      feh
      novelwriter
      polkit
      rpi-imager
      copyq
      autocutsel
    ];
  };

  # https://librewolf.net/docs/settings/

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    backupFileExtension = "backup";
    users = {
      "jc" = import ./home.nix;
    };
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
