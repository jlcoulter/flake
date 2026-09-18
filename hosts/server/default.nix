# Server (ARM) — NixOS configuration.
#
# Headless server with Docker, SSH, Tailscale.
# Uses shared system base and its own minimal home config.
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
  networking.hostName = "server";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # TODO: Generate hardware-configuration.nix on the target machine with
  #       nixos-generate-config and add it to imports above.
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

  # ── Docker ────────────────────────────────────────────────────────────defaul
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
    users.jc = import ./home.nix;
  };

  system.stateVersion = "25.05";
}
