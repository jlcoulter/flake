{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    tree-sitter
    fzf
    ripgrep
    fd
  ] ++ lib.optionals pkgs.stdenv.isLinux [ xclip ];

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
          # Core plugins
          vimPlugins.nvim-neoclip-lua
          vimPlugins.blink-indent
          vimPlugins.mason-nvim
          vimPlugins.gruvbox-material
          vscode-extensions.sainnhe.gruvbox-material

          # Navigation & Motion
          vimPlugins.leap-nvim
          vimPlugins.vim-visual-multi
          vimPlugins.sneak
          vimPlugins.easymotion

          # Git
          vimPlugins.fugitive
          vimPlugins.gitsigns
          vimPlugins.git-messenger

          # UI Enhancements
          vimPlugins.nvim-notify
          vimPlugins.toggleterm-nvim
          vimPlugins.which-key-nvim
          vimPlugins.telescope-undo-nvim

          # Snippets
          vimPlugins.luasnip

          # Testing
          vimPlugins.neotest
          vimPlugins.nvim-jdtls
        ];
        utility = {
          oil-nvim.enable = true;
        };
        autopairs.nvim-autopairs.enable = true;
        options = {
          shiftwidth = 4;
          tabstop = 4;
          expandtab = true;
          smartindent = true;
          autoindent = true;
          indentexpr = "";
          scrolloff = 8;
          sidescrolloff = 8;
          splitright = true;
          splitbelow = true;
          showmode = false;
          signcolumn = "yes";
          colorcolumn = "80";
          mouse = "a";
        };
        statusline.lualine.enable = true;
        statusline.lualine.theme = "gruvbox-material";
        telescope.enable = true;
        globals.mapleader = " ";
        globals.maplocalleader = "\\";

        autocomplete = {
          nvim-cmp.enable = true;
          nvim-cmp.cmdlines = true;
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
          gitsigns.signs = true;
          gitsigns.numhl = true;
          gitsigns.linehl = true;
          gitsigns.current_line_blame = true;
        };

        formatter = {
          conform-nvim = {
            enable = true;
          };
        };

        fzf-lua.enable = true;

        debugger = {
          nvim-dap.enable = true;
          dap-ui.enable = true;
        };
        diagnostics = {
          enable = true;
          nvim-lint.enable = true;
          nvim-lint.lint_after_save = true;
          config.signs = true;
          config.virtual_text = true;
          config.severity_sort = true;
        };

        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
          lightbulb.enable = false;
          trouble.enable = true;
        };

        which-key = {
          enable = true;
          register_mappings = {
            normal_mode = {
              ["<leader>"] = {
                name = "General";
                ["w"] = { "<cmd>w<cr>", "Save" };
                ["q"] = { "<cmd>q<cr>", "Quit" };
                ["/"] = { "<cmd>CommentToggle<cr>", "Comment" };
                ["."] = { "<cmd>cd ~/dotfiles<cr>", "Dotfiles" };
              };
              ["g"] = {
                name = "Go to";
                ["d"] = { "<cmd>GoToDebugConsole<cr>", "Debug Console" };
              };
            };
            visual_mode = {
              ["<leader>"] = {
                name = "Visual";
                ["/"] = { "<cmd>CommentToggle<cr>", "Comment" };
                ["p"] = { "\"_dP", "Paste without yank" };
              };
            };
          };
        };

        notify = {
          enable = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
            size = 20;
            open_mapping = "<c-\\>";
            direction = "horizontal";
          };
        };
      };
    };
  };
}