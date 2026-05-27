{ pkgs, ... }:
{
  programs.nvf.settings.vim.languages.json = {
    enable = true;
    treesitter.enable = true;
    lsp.enable = true;
  };
}