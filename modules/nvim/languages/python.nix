{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    python3
    black
    pyright
  ];

  programs.nvf.settings.vim.languages.python = {
    enable = true;
    treesitter.enable = true;
    lsp.enable = true;
    format.enable = true;
  };
}