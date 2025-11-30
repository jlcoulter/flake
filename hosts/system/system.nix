let
  locale = "en_AU.UTF-8";
in
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

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
  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 10d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
  nixpkgs.config.allowBroken = true;
  system = {
    autoUpgrade = {
      enable = true;
      dates = "weekly";
    };
  };
  networking = {
    hostName = "jcpc";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        25565
        5678
      ];
      allowedUDPPortRanges = [ ];
    };
  };

  security.rtkit.enable = true;
  services = {
    xserver.xkb.layout = "us";
    tailscale.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };

}
