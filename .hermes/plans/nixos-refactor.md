# NixOS Flake Refactor — Idiomatic Configuration

## Problems Found
1. **Server imports desktop/home.nix** — pulls Hyprland, waybar, GTK theme onto a headless server
2. **system.nix not imported** — firewall, pipewire, tailscale, auto-upgrade, garbage collection are inactive
3. **Self-referential palette** — `palette.bg = palette.bg0` inside the palette attrset causes infinite recursion
4. **hyprpaper defined twice** — in both `desktop/home.nix` and `modules/hypr/hyprland.nix`
5. **`programs.git.settings`** — invalid HM syntax, should be `userName`/`userEmail`/`aliases`
6. **Duplicated packages** — neovim, fonts in both system and home
7. **No shared system base** — boot, locale, timezone, nix settings duplicated across hosts
8. **Theme only in desktop** — not reusable for macbook or future hosts
9. **Hardcoded paths** — `~/flake/hosts/desktop/background.jpg` in multiple places
10. **Locale typo** — `LC_INDENTIFICATION` in system.nix

## Target Structure

```
flake.nix                          # Clean flake with specialArgs
├── modules/
│   ├── shared/
│   │   ├── home.nix               # Shared HM: kitty, zsh, git, zellij, nvim, fonts, aliases
│   │   └── system.nix             # NEW: shared NixOS system settings (locale, timezone, nix gc, etc.)
│   ├── theme/
│   │   ├── everforest.nix         # NEW: palette + GTK/cursor/icon theme definitions
│   │   └── home-theme.nix         # NEW: HM module consuming palette (kitty colours, waybar CSS, zellij)
│   ├── hypr/
│   │   ├── hyprland.nix           # Fixed: remove hyprpaper, use config.theme.wallpaper
│   │   └── hyprland.lua           # Unchanged
│   ├── desktop/
│   │   ├── hyprland.nix          # NEW: NixOS module enabling hyprland, ly, waybar programs
│   │   └── gaming.nix             # NEW: steam, gamescope, xwayland, gamemode
│   ├── nvim/                      # Unchanged
│   ├── zen/zen.nix                # Unchanged
│   └── printer/printer.nix       # Unchanged
├── hosts/
│   ├── desktop/
│   │   ├── default.nix            # RENAMED from configuration.nix; imports shared system + desktop modules
│   │   ├── home.nix               # Slim: imports shared/home + theme + hyprland
│   │   ├── hardware-configuration.nix
│   │   ├── nfs.nix                 # Unchanged
│   │   └── background.jpg
│   ├── macbook/
│   │   ├── default.nix            # darwin config
│   │   └── home.nix               # Slim: imports shared/home + theme (kitty colours only)
│   └── server/
│       ├── default.nix            # Fixed: NO desktop home.nix, uses shared/home only
│       └── home.nix               # NEW: server-specific HM (just shared/home, no hyprland/theme)
├── secrets/                        # Future: age-encrypted secrets
└── flake.nix
```

## Tasks

### Phase 1: Extract shared modules
- [ ] Create `modules/shared/system.nix` — shared NixOS base (locale, timezone, nix gc/experimental-features, zsh enable, allowUnfree)
- [ ] Create `modules/theme/everforest.nix` — palette attrset as a Nix module option, fix self-referential aliases
- [ ] Create `modules/theme/home-theme.nix` — HM module that applies palette to kitty, waybar, zellij, GTK, cursor

### Phase 2: Create desktop NixOS modules (extract from monolithic configuration.nix)
- [ ] Create `modules/desktop/hyprland.nix` — NixOS-level Hyprland/ly/waybar/pipewire/rtkit enable
- [ ] Create `modules/desktop/gaming.nix` — steam, gamescope, xwayland, gamemode, graphics

### Phase 3: Fix host configs
- [ ] Rewrite `hosts/desktop/default.nix` (from configuration.nix) — import shared system, desktop modules, hardware, nfs, zen, printer; remove duplicated settings
- [ ] Slim down `hosts/desktop/home.nix` — import shared/home + theme/home-theme + hyprland module; remove duplicate hyprpaper
- [ ] Fix `modules/hypr/hyprland.nix` — remove hardcoded wallpaper path, remove hyprpaper config (moved to home-theme), use config.theme
- [ ] Create `hosts/server/home.nix` — import shared/home only, no hyprland/theme
- [ ] Fix `hosts/server/default.nix` — import server home.nix, remove desktop home.nix import, add shared system module
- [ ] Fix `hosts/macbook/home.nix` — import theme/home-theme for kitty colours (macOS-safe)

### Phase 4: Fix shared/home.nix bugs
- [ ] Fix `programs.git.settings` → `programs.git.userName` / `userEmail` / `aliases`
- [ ] Make `update` alias cross-platform (nixos-rebuild vs darwin-rebuild)
- [ ] Remove duplicate packages (neovim from home.packages since nvf handles it, fonts to system only)

### Phase 5: Update flake.nix
- [ ] Update flake.nix to reference renamed files, add server-amd module back
- [ ] Pass `self` path so wallpaper references aren't hardcoded to `~/flake/...`

### Phase 6: Verify
- [ ] `nix flake check` passes (or `nixos-rebuild build` for desktop)
- [ ] `nixos-rebuild dry-activate` for desktop shows no errors
- [ ] `nix build .#darwinConfigurations.macbook.system` (or equivalent) checks