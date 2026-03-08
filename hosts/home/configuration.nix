{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../system/system.nix
    ../system/nfs.nix
    ../../modules/bluetooth/bluetooth.nix
    ../../modules/virt/virt.nix
    ../../modules/printer/printer.nix
    ../../modules/nvim/nvf.nix
    ../../modules/leftwm/leftwm.nix
    ../../modules/hyprland/hyprland.nix
    #../../modules/nvim/nixvim.nix
  ];

  nixpkgs.config.allowUnfree = true;
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelModules = [ "sg" ];
  };
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
    rsync.enable = true;
    xserver = {
      enable = true;
      xkb.layout = "us";
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
      postgresql
      neovim
      git
      alacritty
      thunderbird
      element-desktop
      easyeffects
      marktext
      vscode
      nmap
      gimp
      spotify
      mgba
      libreoffice
      rpi-imager
      nfs-utils
      vlc
      ffmpeg
      sshfs
      direnv
      nix-direnv
      unzip
      ollama
      ripgrep
      fd
      dbeaver-bin
      postgresql
    ];
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [
      "openLibrary"
      "userData"
    ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
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
