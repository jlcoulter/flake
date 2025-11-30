{
  pkgs,
  ...
}:
{
  programs = {
    hyprland.enable = true;
    sway.enable = true;
    waybar.enable = true;
  };
  programs.uwsm.enable = true;
  programs.uwsm.waylandCompositors = {
    hyprland = {
      prettyName = "Hyprland";
      comment = "Hyprland compositor managed by UWSM";
      binPath = "/run/current-system/sw/bin/Hyprland";
    };
  };

  #  services.displayManager.ly.enable = true;

  environment.systemPackages = with pkgs; [
    wofi
    hyprpaper
    hyprcursor
    dunst
    pipewire
    wireplumber
    hyprpolkitagent
    hyprsunset
    # hypridle
    # hyprlock
    nwg-look
    pywal
  ];
}
