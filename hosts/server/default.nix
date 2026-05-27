{ pkgs, inputs, ... }:

{
  imports = [
    ../../modules/nvim/nvf.nix
  ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "server";
  networking.networkmanager.enable = true;

  time.timeZone = "Australia/Sydney";

  i18n.defaultLocale = "en_GB.UTF-8";

  services = {
    openssh.enable = true;
    tailscale.enable = true;

    docker = {
      enable = true;
      enableOnBoot = true;
      daemon.settings = {
        log-driver = "json-file";
        log-opts = {
          max-size = "10m";
          max-file = "3";
        };
      };
    };
  };

  users.users.jc = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Jack Coulter";
    extraGroups = [
      "wheel"
      "docker"
    ];
    packages = with pkgs; [
      git
      htop
      neovim
      curl
      wget
      rsync
      unzip
      docker
      docker-compose
      ctop
      lazydocker
    ];
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    mesa
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    users = {
      "jc" = import ../desktop/home.nix {
        inherit inputs;
      };
    };
  };

  system.stateVersion = "25.05";
}