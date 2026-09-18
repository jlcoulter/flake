{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    jdt-language-server
    astyle
    maven
    jdk
  ];

  programs.nvf.settings.vim.languages.java = {
    enable = true;
    treesitter.enable = true;
    lsp.enable = true;
    format.enable = true;
  };
}
