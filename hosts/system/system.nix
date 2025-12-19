{ pkgs, lib, ... }:

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

  services.udev.packages = lib.singleton (
    pkgs.writeTextFile {
      name = "keychron-no-joystick";
      text = ''
        KERNEL=="event*", SUBSYSTEM=="input", ENV{ID_VENDOR_ID}=="3434", ENV{ID_INPUT_JOYSTICK}=="*?", ENV{ID_INPUT_JOYSTICK}=""
      '';
      destination = "/etc/udev/rules.d/69-keychron-no-joystick.rules";
    }
  );

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
