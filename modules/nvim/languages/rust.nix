{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    rust-analyzer
    rustup
    dbeaver-bin
  ];

  programs.nvf.settings.vim.languages.rust = {
    enable = true;
    treesitter.enable = true;
    dap.enable = true;
    format.enable = true;
    format.type = [ "rustfmt" ];
    lsp.enable = true;
  };
}
