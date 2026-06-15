{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nvim/base.nix
    ../../modules/nvim/languages/go.nix
    ../../modules/nvim/languages/nix.nix
    ../../modules/printer/printer.nix
    ../../modules/zen/zen.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "jcpc";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Hyprland.nix
  programs.hyprland.enable = true;
  services.displayManager.ly.enable = true;

  # Steam.nix
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  programs.xwayland.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  programs.gamemode.enable = true;

  users.users.jc = {
    isNormalUser = true;
    description = "Jack Coulter";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      kitty
      brave
      waybar
      zsh
      hyprlock
      hyprlauncher
      hyprpolkitagent
      hyprcursor
      hyprsunset
      hyprpaper
      copyq
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    users = {
      "jc" = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    git
  ];

  system.stateVersion = "25.05"; # Did you read the comment?

}
