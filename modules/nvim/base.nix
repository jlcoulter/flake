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
          fold = true;
          textobjects.enable = true;
        };
        clipboard.enable = true;
        startPlugins = with pkgs.vimPlugins; [
          nvim-neoclip-lua
          blink-indent
          mason-nvim
          gruvbox-material
          harpoon
          git-blame-nvim
          nvim-spectre
          bufferline-nvim
          nvim-scrollview
          noice-nvim
          dressing-nvim
          vim-fugitive
          octo-nvim
          refactoring-nvim
          todo-comments-nvim
          treewalker-nvim
          which-key-nvim
          vim-visual-multi
          rainbow-delimiters-nvim
          vim-illuminate
        ];
        utility = {
          oil-nvim.enable = true;
        };
        autopairs.nvim-autopairs.enable = true;
        options = {
          shiftwidth = 4;
          tabstop = 4;
          expandtab = true;
        };
        statusline.lualine.enable = true;
        statusline.lualine.theme = "gruvbox-material";
        telescope.enable = true;
        globals.mapleader = ",";
        globals.maplocalleader = "\\";

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
