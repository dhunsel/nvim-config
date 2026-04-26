# nvim-config

Personal Neovim configuration. Managed with [lazy.nvim](https://github.com/folke/lazy.nvim), which bootstraps itself automatically on first launch.

## Requirements

- Neovim 0.12+
- Git
- A [Nerd Font](https://www.nerdfonts.com/) (for icons in the statusline)
- Node.js (for TypeScript/ESLint LSP servers)

## Installation

```sh
git clone git@github.com:dhunsel/nvim-config.git ~/.config/nvim
```

Launch Neovim — lazy.nvim will install all plugins on the first run.

### Language servers

The following language servers need to be installed separately:

| Language | Server | Notes |
|---|---|---|
| TypeScript / JavaScript | [typescript-tools.nvim](https://github.com/pmizio/typescript-tools.nvim) | Uses the project's local `tsserver` |
| C# / Razor | [roslyn.nvim](https://github.com/seblj/roslyn.nvim) | Install via `:RoslynInstall` |
| TailwindCSS | `tailwindcss-language-server` | `npm i -g @tailwindcss/language-server` |
| ESLint | `vscode-eslint-language-server` | Installed to `~/.local/share/nvim/eslint-lsp/` |
| GDScript (Godot) | Built into Godot editor | Auto-enabled when `project.godot` is detected |

### Formatters

| Language | Formatter |
|---|---|
| JS / TS / CSS / HTML / JSON | `prettierd` (falls back to `prettier`) |
| C# | `csharpier` |

Formatting runs automatically on save.

## Plugins

| Plugin | Purpose |
|---|---|
| [catppuccin](https://github.com/catppuccin/nvim) | Colorscheme (macchiato flavour) |
| [blink.cmp](https://github.com/saghen/blink.cmp) | Completion (LSP, path, snippets, buffer) |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Format on save |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |
| [typescript-tools.nvim](https://github.com/pmizio/typescript-tools.nvim) | TypeScript/JavaScript LSP |
| [roslyn.nvim](https://github.com/seblj/roslyn.nvim) | C# / Razor LSP |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | Auto-close and rename HTML/JSX tags |

## Keymaps

Leader key: `<Space>`

### Navigation

| Key | Action |
|---|---|
| `<A-h/j/k/l>` | Move between windows (normal, insert, terminal) |
| `<Esc>` | Exit terminal mode |
| `jj` | Exit insert mode |
| `<Esc>` | Clear search highlights (normal mode) |
| `<leader>bn` / `<leader>bp` | Next / previous buffer |

### LSP

| Key | Action |
|---|---|
| `gd` / `gsd` / `gvd` | Go to definition (current / horizontal split / vertical split) |
| `gD` / `gsD` / `gvD` | Go to declaration |
| `gI` / `gsI` / `gvI` | Go to implementation |
| `gy` / `gsy` / `gvy` | Go to type definition |
| `gr` | References |
| `K` | Hover documentation |
| `gK` / `<C-k>` | Signature help |
| `<leader>cr` | Rename symbol |
| `<leader>ca` | Code action |
