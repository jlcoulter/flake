# Shared home-manager config — imported by all hosts.
#
# Provides: kitty, zsh, git, zellij, neovim (via nvf), fonts, aliases.
# Theme colours are applied separately via modules/theme/home-theme.nix.
{ pkgs, lib, ... }:

{
  home = {
    username = lib.mkDefault (if pkgs.stdenv.isDarwin then "jlcoulter" else "jc");
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/jlcoulter" else "/home/jc";
    stateVersion = "24.11";
  };

  home.shellAliases = {
    vim = "nvim";
    vi = "nvim";
    flake = "cd ~/flake && nvim ~/flake/flake.nix";
    clobber = "git add . && git commit -m \"$(date)\" && git push";
  }
  // lib.optionalAttrs (!pkgs.stdenv.isDarwin) {
    update = "sudo nixos-rebuild switch --flake ~/flake/#default";
  }
  // lib.optionalAttrs pkgs.stdenv.isDarwin {
    update = "darwin-rebuild switch --flake ~/flake";
  };

  programs = {
    git = {
      enable = true;
      settings = {
        user.name = "jlcoulter";
        user.email = "coulter.l.jack@gmail.com";
        aliases = {
          pu = "push";
          co = "checkout";
          cm = "commit";
        };
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      autocd = true;
      initContent = ''
        export PATH="$HOME/.local/bin:$PATH"

        function check_kbauto_env() {
          if [[ "$PWD" == "/home/jc/git/kbauto"* ]]; then
            export OPENSSL_DIR="${pkgs.openssl.dev}"
            export OPENSSL_LIB_DIR="${pkgs.openssl.out}/lib"
            export PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig"
          else
            unset OPENSSL_DIR OPENSSL_LIB_DIR PKG_CONFIG_PATH
          fi
        }

        chpwd_functions+=(check_kbauto_env)
        check_kbauto_env
      '';
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "agnoster";
      };
    };

    kitty = {
      enable = true;
      font = {
        name = "Fira Code";
        size = 16;
      };
      shellIntegration.enableZshIntegration = true;
      settings = {
        shell = "zsh";
        confirm_os_window_close = 0;
        background_opacity = "0.85";
        background_blur = 1;
        disable_ligatures = "never";
        bold_font = "Fira Code Bold";
        italic_font = "Fira Code Italic";
        bold_italic_font = "Fira Code Bold Italic";
      };
    };

    zellij = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        simplified_ui = true;
        pane_frames = false;
        show_startup_tips = false;
        copy_on_select = true;
        mouse_mode = true;
        scroll_buffer_size = 10000;
        default_layout = "compact";
      };
      extraConfig = ''
        keybinds clear-defaults=true {
          locked {
              bind "Ctrl g" { SwitchToMode "normal"; }
          }
          normal {
              bind "Ctrl p" { SwitchToMode "pane"; }
              bind "Ctrl t" { SwitchToMode "tab"; }
              bind "Ctrl n" { SwitchToMode "resize"; }
              bind "Ctrl s" { SwitchToMode "scroll"; }
              bind "Ctrl o" { SwitchToMode "session"; }
          }
          pane {
              bind "left" { MoveFocus "left"; }
              bind "down" { MoveFocus "down"; }
              bind "up" { MoveFocus "up"; }
              bind "right" { MoveFocus "right"; }
              bind "n" { NewPane; SwitchToMode "normal"; }
              bind "d" { NewPane "down"; SwitchToMode "normal"; }
              bind "r" { NewPane "right"; SwitchToMode "normal"; }
              bind "x" { CloseFocus; SwitchToMode "normal"; }
              bind "f" { ToggleFocusFullscreen; SwitchToMode "normal"; }
              bind "z" { TogglePaneFrames; SwitchToMode "normal"; }
              bind "w" { ToggleFloatingPanes; SwitchToMode "normal"; }
              bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "normal"; }
              bind "c" { SwitchToMode "renamepane"; PaneNameInput 0; }
              bind "h" { MoveFocus "left"; }
              bind "j" { MoveFocus "down"; }
              bind "k" { MoveFocus "up"; }
              bind "l" { MoveFocus "right"; }
              bind "Ctrl p" { SwitchToMode "normal"; }
          }
          tab {
              bind "left" { GoToPreviousTab; }
              bind "down" { GoToNextTab; }
              bind "up" { GoToPreviousTab; }
              bind "right" { GoToNextTab; }
              bind "n" { NewTab; SwitchToMode "normal"; }
              bind "x" { CloseTab; SwitchToMode "normal"; }
              bind "r" { SwitchToMode "renametab"; TabNameInput 0; }
              bind "s" { ToggleActiveSyncTab; SwitchToMode "normal"; }
              bind "1" { GoToTab 1; SwitchToMode "normal"; }
              bind "2" { GoToTab 2; SwitchToMode "normal"; }
              bind "3" { GoToTab 3; SwitchToMode "normal"; }
              bind "4" { GoToTab 4; SwitchToMode "normal"; }
              bind "5" { GoToTab 5; SwitchToMode "normal"; }
              bind "h" { GoToPreviousTab; }
              bind "j" { GoToNextTab; }
              bind "k" { GoToPreviousTab; }
              bind "l" { GoToNextTab; }
              bind "Ctrl t" { SwitchToMode "normal"; }
          }
          resize {
              bind "left" { Resize "Increase left"; }
              bind "down" { Resize "Increase down"; }
              bind "up" { Resize "Increase up"; }
              bind "right" { Resize "Increase right"; }
              bind "h" { Resize "Increase left"; }
              bind "j" { Resize "Increase down"; }
              bind "k" { Resize "Increase up"; }
              bind "l" { Resize "Increase right"; }
              bind "+" { Resize "Increase"; }
              bind "-" { Resize "Decrease"; }
              bind "=" { Resize "Increase"; }
              bind "Ctrl n" { SwitchToMode "normal"; }
          }
          scroll {
              bind "e" { EditScrollback; SwitchToMode "normal"; }
              bind "Ctrl s" { SwitchToMode "normal"; }
          }
          session {
              bind "Ctrl o" { SwitchToMode "normal"; }
              bind "d" { Detach; }
          }
          shared_except "locked" "pane" "tab" "resize" "scroll" "session" "renametab" "renamepane" "entersearch" {
              bind "Ctrl g" { SwitchToMode "locked"; }
              bind "Alt left" { MoveFocusOrTab "left"; }
              bind "Alt right" { MoveFocusOrTab "right"; }
              bind "Alt h" { MoveFocusOrTab "left"; }
              bind "Alt l" { MoveFocusOrTab "right"; }
              bind "Alt j" { MoveFocus "down"; }
              bind "Alt k" { MoveFocus "up"; }
              bind "Alt n" { NewPane; }
              bind "Alt [" { GoToPreviousTab; }
              bind "Alt ]" { GoToNextTab; }
              bind "Ctrl q" { Quit; }
          }
          shared_except "locked" "normal" "entersearch" "renametab" "renamepane" {
              bind "enter" { SwitchToMode "normal"; }
          }
          shared_except "locked" "normal" "entersearch" "renametab" "renamepane" {
              bind "esc" { SwitchToMode "normal"; }
          }
        }
      '';
    };
  };

  home.packages = with pkgs; [
    htop
    fastfetch
    yazi
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
