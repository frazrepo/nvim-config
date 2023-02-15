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

-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/main/lua/lsp-zero/nvim-cmp-setup.lua
-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
-- cmp options
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

vim.opt.completeopt  = { 'menu', 'menuone', 'noselect'}

local cmp = require('cmp')
local luasnip = require ('luasnip')

lsp.setup_nvim_cmp({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    -- ['<Tab>'] = cmp.mapping.confirm({ select = false}),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
      -- they way you will only jump inside the snippet region
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp', keyword_length = 3},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()