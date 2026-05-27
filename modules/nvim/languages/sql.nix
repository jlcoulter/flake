{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    sqlc
    sqlfluff
    sqls
    goose
  ];

  programs.nvf.settings.vim.languages.sql = {
    enable = true;
    treesitter.enable = true;
    lsp.enable = true;
  };
}