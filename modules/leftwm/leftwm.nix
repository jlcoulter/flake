{
  pkgs,
  ...
}:
{
  services = {
    xserver = {
      enable = true;
      windowManager.leftwm.enable = true;
    };

    displayManager.ly.enable = true;
    picom.enable = true;
  };
  environment.systemPackages = with pkgs; [
    rofi
    dunst
    pipewire
    wireplumber
    nwg-look
    pywal
    feh
    polybar
  ];
}
