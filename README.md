# omaterm

Make the [Tern](https://stencil.so/tern) terminal match the rest of your [Omarchy](https://omarchy.org) desktop. It uses your active theme's colors for the terminal background, foreground, window chrome, all 16 ANSI colors, and Tern's UI and syntax colors, and it follows every `omarchy theme set` automatically.

## Install

```bash
git clone https://github.com/betizzel/omaterm ~/Developer/omaterm
~/Developer/omaterm/install.sh
```

If Tern is running during install, select the theme once: **Settings → Theme → omarchy** (dark and light). With Tern closed, the installer selects it for you.

## How it works

| Piece | Installed to | Role |
|---|---|---|
| `tern.json.tpl` | `~/.config/omarchy/themed/` | Omarchy renders it from `colors.toml` on every theme switch |
| `sync.sh` | `~/.local/share/omaterm/` | Copies the rendered theme to `~/.omp/agent/themes/omarchy.json` |
| hook | `~/.config/omarchy/hooks/theme-set.d/omaterm` | Runs `sync.sh` after theme changes |

Tern loads custom themes from omp's theme directory (`~/.omp/agent/themes`), so the `omarchy` theme also appears in omp's `/theme` picker. The file is an omp theme plus a `terminal` block for Tern's terminal colors.

Tern rewrites its `settings.json` from memory while running, so pick the theme inside Tern rather than editing the file by hand.

To change the look, edit `tern.json.tpl` and re-run `install.sh`. Template tokens such as `{{ accent }}` and `{{ mix background accent 22% }}` are documented in Omarchy's theming docs.

## Update

```bash
git -C ~/Developer/omaterm pull
~/Developer/omaterm/install.sh
```

## Uninstall

```bash
~/Developer/omaterm/uninstall.sh
```

Then pick another theme in Tern's settings.
