{ config, pkgs, ...}:

{
  fonts.fontconfig = {
    enable = true;
    # defaultFonts.monospace = [JetBrains Mono];
  };
  home.packages = with pkgs; [
    jetbrains-mono
  ];

}
