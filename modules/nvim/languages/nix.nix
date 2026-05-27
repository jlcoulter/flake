{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixd
    statix
    deadnix
  ];

  programs.nvf.settings.vim.languages.nix = {
    enable = true;
    treesitter.enable = true;
    format.enable = true;
    format.type = [ "nixfmt" ];
    lsp.enable = true;
    lsp.servers = [ "nixd" ];
    extraDiagnostics.enable = true;
    extraDiagnostics.types = [
      "statix"
      "deadnix"
    ];
  };
}