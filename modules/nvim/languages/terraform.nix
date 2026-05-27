{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    terraform
    opentofu
    tofu-ls
  ];

  programs.nvf.settings.vim.languages.terraform = {
    enable = true;
    treesitter.enable = true;
    lsp.enable = true;
  };
}