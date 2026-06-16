{ pkgs, lib, ... }:

{
  environment.systemPackages =
    with pkgs;
    [
      tree-sitter
      fzf
      ripgrep
      fd
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [ xclip ];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        treesitter = {
          enable = true;
          autotagHtml = true;
          context.enable = true;
          fold = false;
          textobjects.enable = true;
        };
        clipboard.enable = true;
        startPlugins = with pkgs.vimPlugins; [
          blink-indent
          everforest
          tiny-inline-diagnostic-nvim
          nvim-lspconfig
        ];

        luaConfigRC.custom-plugin-setups = ''
          require("tiny-inline-diagnostic").setup({ preset = "modern"})
               	'';

        utility = {
          oil-nvim.enable = true;
        };

        ui = {
          illuminate.enable = true;
        };

        autopairs.nvim-autopairs.enable = true;
        options = {
          shiftwidth = 2;
          tabstop = 2;
          expandtab = false;
        };
        statusline.lualine.enable = true;
        statusline.lualine.theme = "everforest";
        telescope.enable = true;
        globals.mapleader = ",";
        globals.maplocalleader = "\\";

        autocomplete = {
          nvim-cmp.enable = false;
          blink-cmp = {
            enable = true;
            friendly-snippets.enable = true;
            sourcePlugins.spell.enable = true;
          };

        };

        mini.icons.enable = true;

        theme = {
          enable = true;
          name = "everforest";
          style = "medium";
          transparent = true;
        };

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = true;
          vim-fugitive.enable = true;
        };

        notes.todo-comments.enable = true;

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
          config.virtual_lines = false;
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
