{
  pkgs,
  ...
}:
{
  services = {
    xserver = {
      enable = true;
      windowManager.i3.enable = true;
    };

    displayManager.ly.enable = true;
    picom.enable = true;
  };
  services.xserver.deviceSection = ''
    Option "TearFree" "true"
  '';
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
