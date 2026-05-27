{ pkgs, ... }: {
  home.username = "jlcoulter";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/jlcoulter" else "/home/jc";
  programs.git = {
    enable = true;
    userName = "Jack Coulter";
    userEmail = "coulter.l.jack@gmail.com";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  home.packages = with pkgs; [
    neovim
    htop
  ];

  home.stateVersion = "24.05"; 
}
