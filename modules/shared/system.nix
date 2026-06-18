# Shared NixOS system configuration — imported by all NixOS hosts.
# Contains settings common to desktop, server, and any future hosts.
{ pkgs, lib, ... }:

{
  # ── Nix ──────────────────────────────────────────────────────────────────
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };

  nix.optimise.automatic = true;

  # ── Locale / Timezone ────────────────────────────────────────────────────
  time.timeZone = "Australia/Sydney";

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
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
  };

  # ── Keyboard ─────────────────────────────────────────────────────────────
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # ── Networking defaults ──────────────────────────────────────────────────
  networking.networkmanager.enable = true;

  # ── Shell ────────────────────────────────────────────────────────────────
  programs.zsh.enable = true;

  # ── Allow unfree ─────────────────────────────────────────────────────────
  nixpkgs.config.allowUnfree = true;

  # ── Auto-upgrade (can be overridden per-host) ────────────────────────────
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
  };
}