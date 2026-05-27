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
    opentofu
    tofu-ls
    ansible
    ansible-lint
    stylua
    black
    pyright
    xclip
    sqlfluff
    sqls
    goose
    wl-clipboard
    nodejs
    pnpm
    golines
    eslint_d
    tree-sitter
    vale-ls
    marksman
    ltex-ls
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
          #name = "gruvbox";
          #style = "dark";
          transparent = true;
          #extraConfig = {
          #};
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
          yaml = {
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
          markdown = {
            enable = true;
            treesitter.enable = true;
            format.enable = true;
            lsp.enable = true;
            lsp.servers = [ "marksman" ];
            extensions.markview-nvim.enable = true;
          };
          terraform = {
            enable = true;
            treesitter.enable = true;
            lsp.enable = true;
          };
        };
      };
    };
  };
}
