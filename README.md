# NixOS Flake

Personal NixOS, nix-darwin, and Home Manager configuration managed as a single flake.

## Hosts

| Host | Arch | Role |
|------|------|------|
| `default` | x86_64-linux | Desktop (Hyprland, gaming, daily driver) |
| `server-arm` | aarch64-linux | ARM server (Docker, Tailscale, SSH) |
| `macbook` | aarch64-darwin | macOS laptop (Homebrew + Home Manager) |

## Structure

```
flake/
├── flake.nix                  # Flake inputs + host definitions
├── hosts/
│   ├── desktop/               # Linux desktop
│   │   ├── configuration.nix  # System config (boot, networking, packages)
│   │   ├── hardware-configuration.nix
│   │   ├── home.nix            # Home Manager config
│   │   ├── theme.nix           # Everforest theme (Kitty, Waybar, GTK, Zellij)
│   │   └── background.jpg
│   ├── server/                # ARM server
│   │   └── default.nix        # Docker, SSH, Tailscale, minimal system
│   └── macbook/
│       ├── default.nix        # nix-darwin system + Homebrew casks
│       └── home.nix           # Home Manager for macOS
└── modules/
    ├── shared/home.nix         # Shared HM config (git, zsh, kitty, zellij, neovim)
    ├── nvf/base.nix           # Neovim via nvf (treesitter, LSP, telescope, blink-cmp)
    ├── nvf/languages/          # Per-language LSP configs (go, nix, python, svelte, ...)
    ├── hypr/                   # Hyprland config (Lua + Nix theme injection)
    ├── zen/                    # Zen Browser with policies + search engines
    └── printer/                # Printer config
```

## Features

- **Single-source theming** — Everforest palette defined once in `theme.nix`, applied to Kitty, Waybar, GTK, Zellij, and Hyprland borders via Nix interpolation
- **Cross-platform** — same flake builds NixOS desktop, ARM server, and macOS laptop
- **nvf for Neovim** — Neovim configured declaratively through nvf, not raw init.lua
- **Hyprland via Lua** — window manager config written in Lua with Nix template substitution for theme colours
- **Zen Browser** — declaratively wrapped Firefox with extension policies and custom search engines (NixOS packages, options, wiki, noogle)
- **Home Manager** — shell (zsh + oh-my-zsh), git, kitty, zellij, all declarative

## Rebuild

```bash
# Desktop
sudo nixos-rebuild switch --flake ~/flake/#default

# Server (ARM)
sudo nixos-rebuild switch --flake ~/flake/#server-arm

# macOS
darwin-rebuild switch --flake ~/flake/#macbook
```

## Inputs

- [nixpkgs](https://github.com/NixOS/nixpkgs) (unstable)
- [home-manager](https://github.com/nix-community/home-manager)
- [nvf](https://github.com/notashelf/nvf) (Neovim framework)
- [nix-darwin](https://github.com/LnL7/nix-darwin)
- [zen-browser-flake](https://github.com/youwen5/zen-browser-flake)
- [nixpkgs-python](https://github.com/cachix/nixpkgs-python)

## License

MIT