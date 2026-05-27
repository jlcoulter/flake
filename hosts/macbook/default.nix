{ pkgs, inputs, ... }: {
  imports = [
    ../../modules/nvim/nvf.nix
  ];

  system.primaryUser = "jlcoulter";

  environment.systemPackages = with pkgs; [
    terminal-notifier
  ];

  users.users.jlcoulter = {
    name = "jlcoulter";
    home = "/Users/jlcoulter";
  };

  nix.enable = false;

  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllExtensions = true;
    screencapture.location = "~/Downloads";
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    casks = [
      "kitty"
    ];
  };

  system.stateVersion = 5;
}