-----------------------------------------------------------
-- Neovim LSP configuration file using lsp-zero
-- Plugin: lsp-zero, nvim-lspconfig and mason
-- https://github.com/VonHeikemen/lsp-zero.nvim
-----------------------------------------------------------

local lsp = require('lsp-zero').preset({
    name = 'minimal',
    set_lsp_keymaps = true,
    manage_nvim_cmp = true,
    suggest_lsp_servers = false,
})

-- Additional keybindings
lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr}
  local bind = vim.keymap.set

  -- more keybindings...
  bind('n', '(d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  bind('n', ')d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  -- Second leader : Comma f
  bind('n', ',f', '<cmd>lua vim.lsp.buf.format { async = true } <CR>', opts)

  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format { async = true } ']]

end)

-- make sure this servers are installed
-- see :help lsp-zero.ensure_installed()
lsp.ensure_installed({
    'rust_analyzer',
    'tsserver',
    'eslint',
    'sumneko_lua',
    'powershell_es'
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()