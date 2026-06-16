{ pkgs, inputs, ... }:
{
  imports = [
    ../../modules/nvim/base.nix
    ../../modules/nvim/languages/go.nix
    ../../modules/nvim/languages/svelte.nix
    ../../modules/nvim/languages/yaml.nix
    ../../modules/nvim/languages/json.nix
    ../../modules/nvim/languages/html.nix
    ../../modules/nvim/languages/nix.nix
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
    brews = [
      "tock"
    ];
    casks = [
      "kitty"
      "slack"
      "unifi-identity-endpoint"
      "drawio"
      "canva"
      "microsoft-teams"
      "visual-studio-code"
    ];
  };

  system.stateVersion = 5;
}
