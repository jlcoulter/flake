{
  config,
  pkgs,
  ...
}: {
  services.xserver = {
    enable = true;
    windowManager.leftwm.enable = true;
  };

  services.displayManager.ly.enable = true;
  services.picom.enable = true;

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
