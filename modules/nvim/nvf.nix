{
  pkgs,
  ...
}:
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
    eslint_d
    svelte-language-server
    tree-sitter
    tailwindcss
    tailwindcss-language-server
    typescript
    typescript-language-server
  ];

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
          rust = {
            enable = true;
            treesitter.enable = true;
            lsp.enable = true;
            dap.enable = true;
            format.enable = true;
            format.type = [ "rustfmt" ];
          };

          svelte = {
            enable = true;
            treesitter.enable = true;
            lsp.enable = true;
            format.enable = true;
            format.type = [ "prettier" ];
            extraDiagnostics.enable = true;
            extraDiagnostics.types = [ "eslint_d" ];
          };

          dart = {
            enable = true;
            treesitter.enable = true;
            lsp.enable = false;
            dap.enable = false;
            flutter-tools = {
              enable = true;
              color.enable = true;
              color.virtualText.enable = true;
            };
          };
          python = {
            enable = true;
            treesitter.enable = true;
            lsp.enable = true;
            dap.enable = true;
            format.enable = true;
          };
          ts = {
            enable = true;
            treesitter.enable = true;
            lsp.enable = true;
            format.enable = true;
          };
          yaml = {
            enable = true;
            treesitter.enable = true;
            lsp.enable = true;
          };
          lua = {
            enable = true;
            treesitter.enable = true;
            lsp.enable = true;
            format.type = [ "stylua" ];
          };
          css = {
            enable = true;
            treesitter.enable = true;
            lsp.enable = true;
          };
          tailwind = {
            enable = true;
            lsp.enable = true;
          };

          html = {
            enable = true;
            treesitter.enable = true;
            lsp.enable = true;
          };
          go = {
            enable = true;
            treesitter.enable = true;
            dap.enable = true;
            format.enable = true;
            format.type = [ "golines" ];
            lsp.enable = true;
          };
          sql = {
            enable = true;
            treesitter.enable = true;
            extraDiagnostics.enable = true;
            format.enable = false;
            lsp.enable = true;
          };
          terraform = {
            enable = true;
            treesitter.enable = true;
            lsp.enable = true;
          };
          markdown = {
            enable = true;
            treesitter.enable = true;
            format.enable = true;
            lsp.enable = true;
            extensions.markview-nvim.enable = true;
          };
        };
      };
    };
  };
}
