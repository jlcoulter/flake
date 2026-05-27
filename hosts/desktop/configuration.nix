{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./system.nix
    #../system/nfs.nix
    ../../modules/bluetooth/bluetooth.nix
    ../../modules/virt/virt.nix
    ../../modules/printer/printer.nix
    ../../modules/nvim/nvf.nix
    #../../modules/leftwm/leftwm.nix
    #../../modules/xmonad/xmonad.nix
    #../../modules/hyprland/hyprland.nix
  ];

  nixpkgs.config.allowUnfree = true;
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelModules = [ "sg" ];
  };
  networking.hostName = "jcpc";

  networking.networkmanager.enable = true;

  time.timeZone = "Australia/Sydney";

  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  services = {
    picom.enable = true;
    rsync.enable = true;
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
      displayManager.setupCommands = ''
        ${pkgs.xorg.xrandr} --setmonitor "Virtual-Left" 1280/232x2160/392+0+0 DP-1
        ${pkgs.xorg.xrandr} --setmonitor "Virtual-CenterMain" 2560/465x2160/392+1280+0 DP-1
        ${pkgs.xorg.xrandr} --setmonitor "Virtual-Right" 1280/232x2160/392+3840+0 DP-1
      '';
      deviceSection = ''
        Option "TearFree" "true"
      '';
      desktopManager = {
        xterm.enable = false;
      };
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status-rust
        ];

      };
      xkb.layout = "us";
    };
    desktopManager.plasma6.enable = false;
    displayManager.ly.enable = true;

    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  programs = {
    dconf.enable = true;
    nix-ld.enable = true;

  };

  security = {
    rtkit.enable = true;
  };
  security.pam.services = {
    i3lock-color.enable = true;

  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    fira-code
    fira-code-symbols
  ];

  users.users.jc = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Jack Coulter";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      dunst
      pipewire
      wireplumber
      lxappearance
      pywal
      feh
      lsof
      discord
      chromium
      yazi
      fastfetch
      kitty
      postgresql
      neovim
      git
      lazygit
      hugo
      jq
      wget
      alacritty
      spotify
      thunderbird
      darktable
      element-desktop
      inkscape
      signal-desktop
      drawio
      easyeffects
      nmap
      gimp
      # spotify
      mgba
      rpi-imager
      nfs-utils
      vlc
      ffmpeg
      sshfs
      direnv
      nix-direnv
      unzip
      ripgrep
      fd
      dbeaver-bin
      postgresql
      vscode
      bruno
      docker-compose
      tree
      claude-code
      ollama
      teams-for-linux
      drive
      slack
      satisfactorymodmanager
      gruvbox-material-gtk-theme
    ];
  };

  programs = {
    firefox.enable = true;
    steam.enable = true;
    zsh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    mesa
    vulkan-tools
    libcap
    wl-clipboard
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    users = {
      "jc" = import ../desktop/home.nix;
    };
  };

  system.stateVersion = "25.05";

}
