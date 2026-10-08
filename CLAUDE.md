# CLAUDE.md

Personal Neovim configuration in Lua (lazy.nvim). It must work on Linux, Windows and macOS. Fast startup is a goal.

## Conventions
- **All documentation, comments and commit messages are in English**, including this file and `readme.md`.
- Match the style of the file you edit (indentation varies between files; some use tabs, some spaces).
- Augroups are prefixed `frazvim_` (see the `augroup()` helper in `lua/config/autocmds.lua`).
- Shared helpers live in `lua/config/util.lua`, exposed as the global `FrazVim` (set by `require("config.util").setup()` in `init.lua`). Reuse them (e.g. `FrazVim.root()`, `FrazVim.QuickFixToggle()`) instead of re-implementing.
- `mini.*` plugins come from the `nvim-mini/` org; mason plugins from `mason-org/`.

## Neovim version
- Minimum **0.12**, target **0.13** (nightly). `init.lua` aborts on older versions.
- When using an API that only exists in 0.13, keep a 0.12 fallback (example: `vim.hl.hl_op or vim.hl.on_yank` in `autocmds.lua`).
- Do not use deprecated APIs: `vim.highlight`, `vim.loop`, `client.server_capabilities` (use `client:supports_method()`), `buffer =` in `vim.keymap.set` (use `buf =`), `require("lspconfig")[x].setup`.
- Do not shadow Neovim defaults without a reason (e.g. `Q` is left native: multicursor in 0.13).

## Layout
- `init.lua` – version guard, `FrazVim` global, loads `config.lazy`.
- `lua/config/lazy.lua` – bootstraps lazy.nvim, then loads `options`, `keymaps`, `autocmds`, then imports `plugins` and `plugins.extras`.
- `lua/config/` – `options.lua`, `keymaps.lua` (global mappings, incl. `<C-space>` incremental selection via built-in `an`/`in`), `autocmds.lua` (autocmds + user commands), `util.lua`.
- `lua/plugins/*.lua` – one lazy.nvim spec list per theme:
  - `lsp.lua` – `vim.lsp.config("*")` for capabilities (blink + foldingRange for ufo), per-server overrides in the `servers` table, mason / mason-lspconfig (`automatic_enable`, `stylua` excluded), `LspAttach` mappings.
  - `treesitter.lua` – nvim-treesitter **`main` branch**: parsers via `require("nvim-treesitter").install{}`, highlight/indent enabled in a `FileType` autocmd. No `nvim-treesitter.configs`.
  - `completion.lua` (blink.cmp), `formatting.lua` (conform, `<leader>cf`), `snacks.lua` / `snacks-terminal.lua` (pickers, terminal, dashboard parts), `editor.lua` (neo-tree, which-key groups, bqf), `ui.lua` (lualine, bufferline, gitsigns, ufo, dashboard), `coding.lua` (mini.ai/pairs/align/operators, surround), `motion.lua`, `searching.lua` (grug-far, grepper), `colorscheme.lua` (catppuccin active, tokyonight disabled), `util.lua`.
- `lua/plugins/extras/` – optional plugins, always imported. To disable one, delete the file or start it with `if true then return {} end` (see `template.lua`).
- `lazy-lock.json` – pinned plugin versions.

Before adding a keymap, check for conflicts with `<leader>` groups declared in `editor.lua` (which-key spec) and with existing mappings (`grep -rn "<leader>x" lua/`).

## External requirements
`tree-sitter` CLI >= 0.25 and a C compiler (parser builds), git, ripgrep, fzf, npm (for some Mason packages).

## Lockfile policy
Only commit `lazy-lock.json` after a deliberate `:Lazy update` that was tested. lazy.nvim rewrites it from whatever is installed locally, which may be stale; revert such changes with `git checkout lazy-lock.json` and run `:Lazy restore`.

## Testing changes
Test in an isolated instance so the real plugin data is not touched:
```sh
ln -s "$PWD" ~/.config/nvim-test
NVIM_APPNAME=nvim-test nvim --headless "+Lazy! sync" +qa
NVIM_APPNAME=nvim-test nvim some/file.lua   # then :messages, :checkhealth vim.deprecated
```
Remove `~/.config/nvim-test` and `~/.local/{share,state}/nvim-test`, `~/.cache/nvim-test` afterwards.

Gotchas:
- mason-lspconfig skips `ensure_installed` in headless mode; servers only install in a UI session.
- Stale files from the old nvim-treesitter `master` branch (e.g. `~/.local/share/nvim/lazy/nvim-treesitter/parser/*.so`) shadow the new parsers in `stdpath("data")/site/parser` and cause query errors like `Invalid node type`.

## Git workflow
- Never commit directly on `master`: create a branch (`feature/…`, `chore/…`), push, open a PR with `gh pr create`, merge with a merge commit (`gh pr merge --merge`).
- Remote is plain HTTPS; auth goes through `gh` (never put tokens in the remote URL).
- No Claude attribution anywhere: no `Co-Authored-By: Claude`, no `Claude-Session` trailer in commits, no "Generated with Claude Code" line in PR descriptions.
