{
  config,
  pkgs,
  ...
}: {
  hardware.sane = {
    enable = true;
    extraBackends = [pkgs.utsushi];
  };
  services = {
    printing = {
      enable = true;
      drivers = [pkgs.epson-escpr];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
    udev = {
      packages = [pkgs.utsushi];
    };
  };
}
