# NixOS-level Hyprland desktop setup.
# Enables Hyprland, display manager, Waybar, audio, and related services.
{ pkgs, ... }:

{
  programs.hyprland.enable = true;
  services.displayManager.ly.enable = true;

  # ── Audio (PipeWire) ──────────────────────────────────────────────────
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  # ── Desktop packages ──────────────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    kitty
    waybar
    hyprlock
    hyprlauncher
    hyprpolkitagent
    hyprcursor
    hyprsunset
    copyq
  ];
}