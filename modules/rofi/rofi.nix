{
  pkgs,
  ...
}:
{
  programs = {
    rofi = {
      enable = true;
      extraConfig = {
        font = "JetBrains Mono 12";
        configPath = "./config.rasi";
      };
    };
  };

  environment.systemPackages = with pkgs; [
  ];
}
