{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gopls
    go
    gcc
    delve
    golines
  ];

  programs.nvf.settings.vim.languages.go = {
    enable = true;
    treesitter.enable = true;
    dap.enable = true;
    format.enable = true;
    format.type = [ "golines" ];
    lsp.enable = true;
  };
}