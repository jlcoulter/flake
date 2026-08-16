{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    rust-analyzer
    jq
    mdbook
    litestream
    rustup
    cargo-tauri
    dbeaver-bin
    # Tauri desktop deps
    webkitgtk_4_1
    libappindicator
    librsvg
    dbus
    pkg-config
    patchelf
    # Android targets
    android-tools
    cargo-ndk
    jdk21
    androidenv.androidPkgs.androidsdk
  ];

  environment.sessionVariables = {
    ANDROID_HOME = "${pkgs.androidenv.androidPkgs.androidsdk}/libexec/android-sdk-sdk";
    ANDROID_NDK_HOME = "${pkgs.androidenv.androidPkgs.androidsdk}/libexec/android-sdk-sdk/ndk-bundle";
    NDK_HOME = "${pkgs.androidenv.androidPkgs.androidsdk}/libexec/android-sdk-sdk/ndk-bundle";
  };

  programs.nvf.settings.vim.languages.rust = {
    enable = true;
    treesitter.enable = true;
    dap.enable = true;
    format.enable = true;
    format.type = [ "rustfmt" ];
    lsp.enable = true;
  };
}
