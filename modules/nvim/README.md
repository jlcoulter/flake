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

### Leap (`leap.nvim`)
- `s` - Jump to any character (forward)
- `S` - Jump to any character (backward)
- `sa` - Jump to any character (including search)
- `f` / `F` - Built-in vim forward/backward

### EasyMotion (`easymotion`)
- `<Leader><Leader>w` - Word forward
- `<Leader><Leader>b` - Word backward
- `<Leader><Leader>j` - Line down
- `<Leader><Leader>k` - Line up

### Telescope
- `<Leader>ff` - Find files
- `<Leader>fg` - Live grep
- `<Leader>fb` - Buffers
- `<Leader>fh` - Help tags
- `<Leader>fr` - Recent files
- `<Leader>fu` - Undo history
- `<Leader>fc` - Commands

### FZF Lua
- `<Leader>zf` - Files
- `<Leader>zg` - Grep
- `<Leader>zb` - Buffers

## Git

### Fugitive (`vim-fugitive`)
- `<Leader>gs` - Git status
- `<Leader>gc` - Git commit
- `<Leader>gp` - Git push
- `<Leader>gl` - Git log
- `git checkout` / `git commit` - Standard git commands in vim

### Gitsigns
- `[c` / `]c` - Next/previous hunk
- `<Leader>hs` - Stage hunk
- `<Leader>hr` - Reset hunk
- `<Leader>hS` - Stage buffer
- `<Leader>hu` - Undo stage

### Git Messenger (`git-messenger`)
- `<Leader>gm` - Show git blame for line

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
<Leader>ff     # Telescope find files
<Leader>fg     # Live grep
<Leader>fr     # Recent files
```

### Working with Git
```
<Leader>gs     # Fugitive status
]c             # Next hunk
<c             # Previous hunk
<Leader>hs     # Stage hunk
```

### Debugging
```
<F5>           # Start debug
<F10>          # Step over
<Leader>dr    # Open REPL
<Leader>do     # Open Dap UI
```

### Moving Around
```
s              # Leap (jump to character)
<Leader><Leader>w   # EasyMotion word forward
```

## Plugins List

| Plugin | Purpose |
|--------|---------|
| `leap.nvim` | Bidirectional cursor movement |
| `vim-visual-multi` | Multiple cursors |
| `sneak` | Quick character jumps |
| `easymotion` | Jump to any visible character |
| `telescope` | Fuzzy finder |
| `fzf-lua` | Alternative fuzzy finder |
| `fugitive` | Git wrapper |
| `gitsigns` | Git signs in gutter |
| `git-messenger` | Inline git blame |
| `nvim-dap` | Debug adapter protocol |
| `dap-ui` | Debug UI |
| `nvim-notify` | Notifications |
| `which-key` | Keybinding hints |
| `toggleterm` | Terminal integration |
| `luasnip` | Snippets |
| `oil.nvim` | File explorer |