# Neovim Quick Start Guide

## Leader Keys

| Key | Action |
|-----|--------|
| `<Space>` | Leader key |
| `<Leader>w` | Save |
| `<Leader>q` | Quit |
| `<Leader>/` | Toggle comment |
| `<Leader>.` | Open dotfiles |

## Navigation & Motion

### Built-in Vim
- `f` / `F` - Forward/backward to character
- `t` / `T` - Forward/backward to before character
- `w` / `b` - Word forward/backward
- `e` / `ge` - Word end forward/backward
- `0` / `$` - Line start/end
- `gg` / `G` - File start/end
- `Ctrl-u` / `Ctrl-d` - Half page up/down
- `zz` - Center cursor

### Telescope (enabled by default via nvf)
- `:Telescope find_files` - Find files
- `:Telescope live_grep` - Live grep
- `:Telescope buffers` - Buffers
- `:Telescope recent` - Recent files
- `:Telescope help_tags` - Help tags
- `:Telescope commands` - Commands
- `:Telescope undo` - Undo history

### FZF Lua (alternative fuzzy finder)
- `:FZF` - Open FZF

## Git

### Fugitive (`vim-fugitive`)
- `:G` or `:Git` - Run any git command
- `:G status` - Open status buffer
- `:G diff` - Open diff view
- `:G log` - Open log view
- `:G commit` - Create commit
- `:G push` - Push to remote
- `:G pull` - Pull from remote
- In status buffer: `cc` to commit, `ca` to amend, `p` to push

### Gitsigns
- `]c` / `[c` - Next/previous hunk
- `s` - Stage hunk (visual mode)
- `S` - Stage buffer
- `u` - Undo stage
- `x` - Discard hunk
- `p` - Preview hunk

### Git Messenger (`git-messenger`)
- `<Leader>gm` - Show git blame for current line

## Debugging (DAP)

### Keybindings
- `<F5>` - Start/continue debug
- `<F10>` - Step over
- `<F11>` - Step into
- `<F12>` - Step out
- `<Leader>dr` - Open REPL
- `<Leader>db` - Toggle breakpoint

### Dap UI
- `<Leader>do` - Open Dap UI
- `<Leader>dc` - Close Dap UI

## Terminal

- `<Ctrl-\>` - Toggle terminal
- `<Leader>tf` - Terminal floating

## Which Key

- Type a leader key and wait to see available commands
- Helps discover keybindings

## Common Workflows

### Finding Files
```
:Telescope find_files
:Telescope live_grep
:Telescope buffers
:Telescope recent
```

### Working with Git
```
:G status      # Open Fugitive
]c             # Next hunk
[c             # Previous hunk
s              # Stage hunk (visual mode)
:G commit      # Create commit
:G push        # Push
```

### Debugging
```
:F5             # Start debug (when Dap configured)
:F10            # Step over
:F11            # Step into
```

### Moving Around
```
f + char        # Forward to character
F + char        # Backward to character
t + char        # Forward to before character
T + char        # Backward to before character
```

## Plugins Enabled (via nvf)

| Plugin | Purpose |
|--------|---------|
| `telescope` | Fuzzy finder |
| `fzf-lua` | Alternative fuzzy finder |
| `fugitive` | Git wrapper |
| `gitsigns` | Git signs in gutter |
| `nvim-dap` | Debug adapter protocol |
| `luasnip` | Snippets |
| `oil.nvim` | File explorer |
| `mason` | LSP/dap server management |