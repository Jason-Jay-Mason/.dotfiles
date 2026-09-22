# AGENTS.md — Neovim config migration context

## What this directory is

Dotfiles for Neovim: `~/.dotfiles/neovim/.config` (git repo). Two configs live side by side:

- `nvim/` — the **new** config. A plain **lazy.nvim starter** (NOT the LazyVim distro), being built up from scratch.
- `nvim-old/` — the **old** config being migrated from. Reference only; do not modify.

Never make edits outside this directory (`~/.dotfiles/neovim/.config`).

## Migration approach

- Plugins are added **one at a time**, each in its own file `nvim/lua/plugins/<plugin>.lua`, following the lazy.nvim spec format: https://lazy.folke.io/spec
- Do **not** test or verify changes (no headless nvim runs, no `Lazy! sync`) — the user does that themselves.
- The user sometimes pastes specs from the **LazyVim distro** (they reference `LazyVim.*` helpers like `LazyVim.error`, `LazyVim.treesitter.build/have/set_default`, and the `LazyFile` event). These do not exist in a plain lazy.nvim setup — translate them to plain equivalents while preserving behavior (see `nvim/lua/plugins/treesitter.lua` for the pattern).

## New config structure

- `nvim/init.lua` → `require("config.lazy")`
- `nvim/lua/config/lazy.lua` — bootstraps lazy.nvim, `mapleader = " "`, `maplocalleader = "\\"`, spec imports `{ "plugins" }`
- `nvim/lua/plugins/*.lua` — one spec table (or list of specs) per plugin area

## Decisions made so far

- **Keep old leader keymaps** as-is (muscle memory over LazyVim conventions), e.g. `<leader>f` find_files, `<leader>e` diagnostics, `<leader>g` live_grep.
- **Drop deprecated/archived plugins**: `nvim-lua/popup.nvim`, `nvim-telescope/telescope-media-files.nvim`.
- Telescope: fzf opts belong in top-level `extensions`, not `defaults.extensions` (old config had a subtle bug there). Old `utils.get_popup_size` window sizing gets inlined as local functions in the plugin file rather than recreating `utils.lua`.
- Treesitter: use the **`main` branch** (requires nvim 0.12+ and `tree-sitter-cli` >= 0.26.1 in PATH; both satisfied). Does not support lazy-loading (`lazy = false`). Parsers auto-download at startup via `ensure_installed` + `install()` filter; headless runs block with `:wait()` so bootstrap completes. `svelte` was added on top of the LazyVim default parser list (user chose NOT to add `go`/`css` explicitly, but they got pulled in as dependency parsers).
- Starter placeholder `lua/plugins/example.lua` was deleted.
- nvim-tree: `git.ignore = false` → `filters.git_ignored = false`, `api.config.mappings.default_on_attach` → `api.map.on_attach.default` (both legacy); netrw disabled eagerly in `init`; `nvim-web-devicons` added as a dependency (still to be configured for its own sake).

## Remaining to port from nvim-old

Source of truth: `nvim-old/lua/plugins/init.lua` (specs), `nvim-old/lua/plugins/config/*` (setups), `nvim-old/lua/settings/*` (options, mappings, highlights, autocommands, filetypes).

Already done: telescope (+fzf-native), treesitter (main branch, auto-download), rose-pine colorscheme (`lua/plugins/rose-pine.lua` — old `settings/colors.lua` palette + `settings/highlights.lua` groups inlined as locals, applied in `config` after `vim.cmd.colorscheme`; BufferLine/Telescope/ibl groups are set ahead of those plugins, harmless until they're ported), nvim-tree (`lua/plugins/nvim-tree.lua`).

lspconfig (`lua/plugins/lspconfig.lua`): mason + mason-lspconfig (v2, `automatic_enable` default) with `neovim/nvim-lspconfig`; old diagnostics config (signs `	ed²`-style nerd icons, rounded floats, no virtual_text), old `svelte` (onDidChangeTsOrJsFile HACK) and `rust_analyzer` (`cargo.features = "all"`) server configs, old `M.lsp` keymaps (`ge`/`gh`/`gr`/`gi`/`gf`/`gD`) set buffer-local on `LspAttach`.

blink.cmp (`lua/plugins/blink-cmp.lua`, replaces old nvim-cmp): LazyVim distro spec translated to plain lazy.nvim (`version = "*"` instead of the `lazyvim_blink_main` toggle, no `config` function — the LazyVim `snippets.expand`/compat-sources/ai_accept/symbol-kinds logic all dropped; `preset = "default"` keymap instead of `"enter"`). Old cmp behavior preserved: `["<CR>"] = vim.NIL` → preset `"default"` (CR never accepts, `<C-l>` confirms via `select_and_accept`), old `C-e` complete/`C-f`/`C-u` scroll/`C-k`/`C-j` nav keymaps, `preselect = "item"` → `list.selection.preselect = true`, bordered window → rounded border + `Pmenu` winhighlight, buffer `keyword_length = 3` → `providers.buffer.min_keyword_length = 3`. Old kind-icon table → blink built-in icons (`nerd_font_variant = "mono"`). LSP capabilities via `require("blink.cmp").get_lsp_capabilities()` wired into `vim.lsp.config("*")` at top of the file (replaces `cmp-nvim-lsp`). Ghost text enabled (LazyVim default; old cmp had none). `mappings.lua` had nothing completion-related to port.

Still to do: nvim-web-devicons, bufferline, lualine, todo-comments, nvim-colorizer, codediff. Also port `templ` filetype rule from `nvim-old/lua/settings/filetypes.lua` and the old `settings/options.lua` / `autocommands.lua` / `mappings.lua` bits as they become relevant.
