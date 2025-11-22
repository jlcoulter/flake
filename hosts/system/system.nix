{
  config,
  pkgs,
  ...
}: let
  locale = "en_AU.UTF-8";
in {
  # Boot
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # Locale
  time.timeZone = "Australia/Sydney";
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = locale;
      LC_INDENTIFICATION = locale;
      LC_MEASUREMENT = locale;
      LC_MONETARY = locale;
      LC_NAME = locale;
      LC_NUMERIC = locale;
      LC_PAPER = locale;
      LC_TELEPHONE = locale;
      LC_TIME = locale;
    };
  };

  services.xserver.xkb.layout = "us";

  # Nix upgrade
  nixpkgs.config.allowBroken = true;
  system = {
    autoUpgrade = {
      enable = true;
      dates = "weekly";
    };
  };

  # Version clean-up
  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 10d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
  };

  # Networking
  services.tailscale.enable = true;
  networking = {
    hostName = "jcpc";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [25565 5678];
      allowedUDPPortRanges = [];
    };
  };

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  }

