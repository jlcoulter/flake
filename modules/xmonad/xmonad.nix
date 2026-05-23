{
  pkgs,
  ...
}:
{
  _class = "nixos";
  services = {
    xserver = {
      enable = true;
      windowManager.xmonad.enable = true;
      windowManager.xmonad.enableContribAndExtras = true;
    };

    displayManager.ly.enable = true;
  };
  services.xserver.deviceSection = ''
    Option "TearFree" "true"
  '';
  environment.systemPackages = with pkgs; [
    xmobar

  ];
}
