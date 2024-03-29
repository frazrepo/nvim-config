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

  -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v1.x/lua/lsp-zero/server.lua
  -- default key bindings
  -- map('n', 'K', lsp 'buf.hover()')
  -- map('n', 'gd', lsp 'buf.definition()')
  -- map('n', 'gD', lsp 'buf.declaration()')
  -- map('n', 'gi', lsp 'buf.implementation()')
  -- map('n', 'go', lsp 'buf.type_definition()')
  -- map('n', 'gr', lsp 'buf.references()')
  -- map('n', '<F2>', lsp 'buf.rename()')
  -- map('n', '<F4>', lsp 'buf.code_action()')
  -- map('x', '<F4>', lsp 'buf.range_code_action()')

  -- map('n', '<C-k>', lsp 'buf.signature_help()')

  -- map('n', 'gl', diagnostic 'open_float()')
  -- map('n', '[d', diagnostic 'goto_prev()')
  -- map('n', ']d', diagnostic 'goto_next()')

  -- more keybindings...
  bind('n', '(d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  bind('n', ')d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  -- Second leader : Comma f
  bind('n', ',f', '<cmd>lua vim.lsp.buf.format { async = true } <CR>', opts)
end)

-- make sure this servers are installed
-- see :help lsp-zero.ensure_installed()
-- https://github.com/williamboman/mason-lspconfig.nvim#default-configuration
lsp.ensure_installed({
    'rust_analyzer',
    'lua_ls',
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

local cmp = require('cmp')
local luasnip = require ('luasnip')

lsp.setup_nvim_cmp({
  -- do not select first item
  preselect = 'none',
  completion  = {
    completeopt = 'menu,menuone,noinsert,noselect'
  },
  confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
  },
  mapping = cmp.mapping.preset.insert({
        ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
        ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
        ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable,
        ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
        ['<CR>'] = cmp.mapping.confirm {
            select = false,
        },
        -- supertab config : if not visible, expand
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
    }),
    sources = {
        -- Same behavior as vscode without keyword_length
        {name = 'nvim_lsp', priority = 1000},
        {name = 'luasnip', priority = 750},
        {name = 'buffer', priority = 500},
        {name = 'path', priority = 250},
    },
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()
