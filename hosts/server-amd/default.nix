# Server (AMD64) — NixOS configuration.
#
# This is a template for an x86_64 server. Run `nixos-generate-config`
# on the target machine to generate a proper hardware-configuration.nix,
# then replace the stub below with it.
{ config, pkgs, lib, inputs, self, ... }:

{
  imports = [
    # ── Shared ──
    ../../modules/shared/system.nix
    ../../modules/nvim/base.nix
    ../../modules/nvim/languages/nix.nix
    ../../modules/nvim/languages/go.nix
    ../../modules/nvim/languages/yaml.nix
    ../../modules/nvim/languages/json.nix
  ];

  # ── Host identity ──────────────────────────────────────────────────────
  networking.hostName = "server-amd";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # TODO: Replace with actual hardware-configuration.nix from the target machine
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/CHANGE-ME";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/CHANGE-ME";
    fsType = "vfat";
  };

  # ── User ───────────────────────────────────────────────────────────────
  users.users.jc = {
    isNormalUser = true;
    description = "Jack Coulter";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "docker" ];
  };

  # ── Services ──────────────────────────────────────────────────────────
  services.openssh.enable = true;
  services.tailscale.enable = true;

  # ── Docker ────────────────────────────────────────────────────────────
  virtualisation.docker = {
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

  # ── System packages ───────────────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    git
    docker-compose
    ctop
    lazydocker
  ];

  # ── Home Manager ──────────────────────────────────────────────────────
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    sharedModules = [
      ../../modules/theme/everforest.nix
    ];
    users.jc = import ../server/home.nix;
  };

  system.stateVersion = "25.05";
}