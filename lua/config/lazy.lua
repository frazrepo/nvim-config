-----------------------------------------------------------
-- Plugin manager configuration file
-- Plugin manager: lazy.nvim
-- https://github.com/folke/lazy.nvim
-----------------------------------------------------------
--
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------
-- LSP Provider LSP or coc
-----------------------------------------------------------
-- define lsp provider : native | coc
vim.g.lspprovider = 'native'

-----------------------------------------------------------
-- Options, keymaps and Autocmds
-----------------------------------------------------------
require('config.options')
require('config.keymaps')
require('config.autocmds')

-----------------------------------------------------------
-- Setup Lazy and it's plugins
-----------------------------------------------------------
require("lazy").setup({
    -----------------------------------------------------------
    -- Lazy options
    -----------------------------------------------------------
    install = { colorscheme = { "tokyonight", "habamax" } },
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    spec = {
        -- import main plugins and extra plugins
        { import = "plugins" },
        { import = 'plugins.extras'},
    },
})

-----------------------------------------------------------
-- GUI Options
-----------------------------------------------------------
require('config.ginit')
