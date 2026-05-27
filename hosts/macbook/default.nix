{ pkgs, ... }: {
  system.primaryUser = "jlcoulter";

  environment.systemPackages = with pkgs; [
    terminal-notifier
  ];
  
  users.users.jlcoulter = {
    name = "jlcoulter";
    home = "/Users/jlcoulter";
};

  nix.enable = false;

  # macOS system configurations (dock, trackpad, finder, keyboard)
  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllExtensions = true;
    screencapture.location = "~/Downloads";
  };

  # Optional: Manage Homebrew bundles using nix-darwin
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap"; # Removes apps not listed here
    casks = [
      "kitty"
    ];
  };

  # Necessary for making lookups comply with nix-darwin environment
  system.stateVersion = 5; 
}
