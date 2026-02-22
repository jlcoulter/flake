{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixd
    statix
    deadnix
    gopls
    libcap
    go
    gcc
    exercism
    delve
    terraform
    terraform-ls
    ansible
    ansible-lint
    stylua
  ];
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        startPlugins = [
          pkgs.vimPlugins.lazy-nvim
          pkgs.vimPlugins.ansible-vim
        ];
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
            enable = false;
            cmp = {
              enable = true;
            };
          };
        };
        debugger = {
          nvim-dap.enable = true;
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
          yaml = {
            enable = true;
            lsp.enable = true;
          };
          lua = {
            enable = true;
            lsp.enable = true;
            format.type = [ "stylua" ];
          };
          css = {
            enable = true;
            lsp.enable = true;
          };
          html = {
            enable = true;
            lsp.enable = true;

          };
          go = {
            enable = true;
            dap.enable = true;
            format.enable = true;
            lsp.enable = true;
          };
          terraform = {
            enable = true;
            lsp.enable = true;
          };
          markdown = {
            enable = true;
            format.enable = true;
            lsp.enable = true;
            extensions.markview-nvim.enable = true;
          };
        };
      };
    };
  };
}
