{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nixd
    statix
    deadnix
  ];
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        autopairs.nvim-autopairs.enable = true;
        options.shiftwidth = 2;
        statusline.lualine.enable = true;
        telescope.enable = true;
        globals.mapleader = ",";
        autocomplete.nvim-cmp.enable = true;
        theme = {
          enable = true;
          name = "tokyonight";
          style = "moon";
        };
        assistant = {
          chatgpt.mappings.grammarCorrection.enable = true;
          copilot = {
            enable = true;
            cmp = {
              enable = true;
            };
          };
        };
        diagnostics = {
          enable = true;
          nvim-lint.enable = true;
          nvim-lint.lint_after_save = true;
          config.virtual_lines = true;
        };
        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
          lightbulb.enable = true;
        };
        languages = {
          nix = {
            enable = true;
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
        };
      };
    };
  };
}
