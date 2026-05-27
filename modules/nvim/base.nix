{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    tree-sitter
    fzf
  ] ++ (lib.optionals pkgs.stdenv.isLinux xclip);

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        treesitter = {
          enable = true;
          autotagHtml = true;
          context.enable = true;
          fold = true;
          textobjects.enable = true;
        };
        clipboard.enable = true;
        startPlugins = with pkgs; [
          vimPlugins.nvim-neoclip-lua
          vimPlugins.blink-indent
          vimPlugins.mason-nvim
          vimPlugins.gruvbox-material
          vscode-extensions.sainnhe.gruvbox-material
        ];
        utility = {
          oil-nvim.enable = true;
        };
        autopairs.nvim-autopairs.enable = true;
        options.shiftwidth = 4;
        statusline.lualine.enable = true;
        statusline.lualine.theme = "gruvbox-material";
        telescope.enable = true;
        globals.mapleader = ",";

        autocomplete = {
          nvim-cmp.enable = true;
        };

        mini.icons.enable = true;

        theme = {
          enable = true;
          transparent = true;
        };

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false;
        };

        formatter = {
          conform-nvim = {
            enable = true;
          };
        };

        fzf-lua.enable = true;

        debugger = {
          nvim-dap.enable = true;
        };
        diagnostics = {
          enable = true;
          nvim-lint.enable = true;
          nvim-lint.lint_after_save = true;
          config.signs = true;
          config.virtual_text = true;
        };

        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
          lightbulb.enable = false;
          trouble.enable = true;
        };
      };
    };
  };
}