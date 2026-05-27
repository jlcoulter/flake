{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nodejs
    pnpm
    eslint_d
  ];

  programs.nvf.settings.vim.languages.svelte = {
    enable = true;
    treesitter.enable = true;
    lsp.enable = true;
  };
}