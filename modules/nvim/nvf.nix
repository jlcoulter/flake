{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixd
    sqlc
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
    black
    pyright
    xclip
    sqlfluff
    sqls
    rustfmt
    rust-analyzer
    flutter
    android-tools
    goose
    wl-clipboard
    nodejs
    golines
    tree-sitter
  ];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        clipboard.enable = true;
        startPlugins = with pkgs; [
          vimPlugins.nvim-web-devicons
          vimPlugins.nvim-neoclip-lua
          vimPlugins.blink-indent
          vimPlugins.mason-nvim
        ];
        utility = {
          oil-nvim.enable = true;

        };
        autopairs.nvim-autopairs.enable = true;
        options.shiftwidth = 4;
        statusline.lualine.enable = true;
        telescope.enable = true;
        globals.mapleader = ",";
        treesitter.enable = true;

        autocomplete = {
          blink-cmp.enable = true;
        };

        mini.icons.enable = true;

        theme = {
          enable = true;
          name = "tokyonight";
          style = "moon";
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
          rust = {
            enable = true;
            lsp.enable = true;
            dap.enable = true;
            format.enable = true;
            format.type = [ "rustfmt" ];
            treesitter.enable = true;
          };

          svelte = {
            enable = true;
            lsp.enable = true;
            format.enable = false;
            extraDiagnostics.enable = true;
            extraDiagnostics.types = [ "eslint_d" ];
            treesitter.enable = true;
          };

          dart = {
            enable = true;
            lsp.enable = false;
            dap.enable = false;
            treesitter.enable = true;
            flutter-tools = {
              enable = true;
              color.enable = true;
              color.virtualText.enable = true;
            };
          };
          python = {
            enable = true;
            lsp.enable = true;
            dap.enable = true;
            format.enable = true;
            treesitter.enable = true;
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
            format.type = [ "golines" ];
            lsp.enable = true;
            treesitter.enable = true;
          };
          sql = {
            enable = true;
            extraDiagnostics.enable = true;
            format.enable = false;
            lsp.enable = true;
            treesitter.enable = true;
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
