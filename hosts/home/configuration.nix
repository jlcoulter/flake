{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../system/system.nix
    ../../modules/pcloud/pcloud.nix
    ../../modules/bluetooth/bluetooth.nix
    ../../modules/virt/virt.nix
    ../../modules/printer/printer.nix
    ../../modules/nvim/nvf.nix
  ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "jcpc";

  networking.networkmanager.enable = true;

  time.timeZone = "Australia/Sydney";

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

  services = {
    xserver.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  security.rtkit.enable = true;

  fonts.packages = with pkgs; [
    jetbrains-mono
  ];

  users.users.jc = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Jack Coulter";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      kdePackages.kate
      neovim
      git
      zsh
      alacritty
      thunderbird
      prismlauncher
      element-desktop
      easyeffects
      marktext
      vscode
      nmap
      brave
      nextcloud-client
      gimp
      spotify
      mgba
      kdePackages.calligra
      libreoffice
    ];
  };

  programs = {
    firefox.enable = true;
    steam.enable = true;
    zsh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    mesa
    vulkan-tools
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    users = {
      "jc" = import ./home.nix;
    };
  };

  system.stateVersion = "25.05";

}
