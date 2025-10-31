{
  config,
  pkgs,
  ...
}: {
  programs.hyprland.enable = true;
  programs.waybar.enable = true;

  services.displayManager.ly.enable = true;

  programs.xwayland.enable = true;

  environment.systemPackages = with pkgs; [
    wofi
    hyprpaper
    hyprcursor
    dunst
    pipewire
    wireplumber
    hyprpolkitagent
    hyprsunset
    hypridle
    hyprlock
    nwg-look
    pywal
  ];
}
