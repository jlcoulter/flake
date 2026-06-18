# Desktop (jcpc) — NixOS system configuration.
#
# Imports shared system base, desktop-specific modules (Hyprland, gaming),
# hardware config, NFS mounts, printer, and Zen browser.
# Home-manager is wired in here with theme and Hyprland modules.
{
  config,
  pkgs,
  lib,
  inputs,
  self,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix

    # ── Shared ──
    ../../modules/shared/system.nix

    # ── Neovim (NixOS-level: packages + nvf config) ──
    ../../modules/nvim/base.nix
    ../../modules/nvim/languages/go.nix
    ../../modules/nvim/languages/nix.nix
    ../../modules/nvim/languages/rust.nix

    # ── Desktop modules ──
    ../../modules/desktop/hyprland.nix
    ../../modules/desktop/gaming.nix
    ../../modules/printer/printer.nix
    ../../modules/zen/zen.nix

    # ── NFS mounts ──
    ./nfs.nix
  ];

  # ── Host identity ──────────────────────────────────────────────────────
  networking.hostName = "jcpc";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ── User ────────────────────────────────────────────────────────────────
  users.users.jc = {
    isNormalUser = true;
    description = "Jack Coulter";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      brave
      ollama
      zed-editor
      mcp-nixos
    ];
  };

  # ── Fonts ───────────────────────────────────────────────────────────────
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    nerd-fonts.symbols-only
  ];

  # ── System packages ─────────────────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    git
  ];

  # ── Firewall (desktop-specific ports) ──────────────────────────────────
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      25565
      5678
      21
    ];
    allowedTCPPortRanges = [
      {
        from = 51000;
        to = 51999;
      } # FTP passive
    ];
  };

  services.vsftpd.extraConfig = ''
    pasv_enable=Yes
    pasv_min_port=51000
    pasv_max_port=51999
  '';

  # ── Tailscale ───────────────────────────────────────────────────────────
  services.tailscale.enable = true;

  # ── Udev rules ──────────────────────────────────────────────────────────
  services.udev.packages = lib.singleton (
    pkgs.writeTextFile {
      name = "keychron-no-joystick";
      text = ''
        KERNEL=="event*", SUBSYSTEM=="input", ENV{ID_VENDOR_ID}=="3434", ENV{ID_INPUT_JOYSTICK}=="*?", ENV{ID_INPUT_JOYSTICK}=""
      '';
      destination = "/etc/udev/rules.d/69-keychron-no-joystick.rules";
    }
  );

  # ── Home Manager ────────────────────────────────────────────────────────
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    sharedModules = [
      ../../modules/theme/everforest.nix
    ];
    users.jc = import ./home.nix;
  };

  system.stateVersion = "25.05";
}

