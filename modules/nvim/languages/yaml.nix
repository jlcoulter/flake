{ pkgs, ... }:
{
  programs.nvf.settings.vim.languages.yaml = {
    enable = true;
    treesitter.enable = true;
    lsp.enable = true;
  };
}