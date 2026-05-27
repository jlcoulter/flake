{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    marksman
    vale-ls
  ];

  programs.nvf.settings.vim.languages.markdown = {
    enable = true;
    treesitter.enable = true;
    format.enable = true;
    lsp.enable = true;
    lsp.servers = [ "marksman" ];
    #extensions.markview-nvim.enable = true;
  };
}