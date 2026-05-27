{ pkgs, lib, ... }:

# =============================================================================
# NVF PLUGIN OPTIONS - Uncomment to enable additional plugins
# =============================================================================
# ALREADY ENABLED:
#   - nvim-neoclip-lua, blink-indent, mason-nvim, gruvbox-material
#   - luasnip, oil-nvim, telescope, fzf-lua
#   - lualine, nvim-cmp, mini-icons
#   - theme (gruvbox, transparent)
#   - gitsigns, conform-nvim, nvim-dap
#   - diagnostics, lsp (with trouble, inlay hints)
#   - treesitter (all features)
#
# AVAILABLE TO ENABLE:
#   git.fugitive.enable = true           # Git wrapper (:G)
#   git.git-messenger.enable = true        # Inline blame
#   git.neogit.enable = true              # Git TUI
#   notify.nvim-notify.enable = true      # Notifications
#   which-key.enable = true              # Keybinding hints
#   toggleterm.enable = true              # Terminal integration
#   zen-mode-nvim.enable = true          # Zen mode
#   debugger.dap-ui.enable = true         # DAP UI
#   debugger.dap-virtual-text.enable = true
#   aerial-nvim.enable = true             # Symbol outline
#   mini-ai.enable = true                 # AI indent object
#   rainbow-delimiters.enable = true       # Rainbow brackets
#
# =============================================================================

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
        startPlugins = with pkgs; [
          # Core plugins
          vimPlugins.nvim-neoclip-lua
          vimPlugins.blink-indent
          vimPlugins.mason-nvim
          vimPlugins.gruvbox-material
          vscode-extensions.sainnhe.gruvbox-material

          # Snippets
          vimPlugins.luasnip
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
