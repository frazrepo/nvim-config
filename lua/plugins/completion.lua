-----------------------------------------------------------
-- Autocomplete configuration file
-- Plugin: nvim-cmp
-- Taken from : 
-- https://github.com/mxdevmanuel/dotfiles/blob/master/neovim/.config/nvim/lua/completion.lua
-- https://github.com/hrsh7th/nvim-cmpa
-----------------------------------------------------------

local M = {}

function M.setup()

    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and
                   vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(
                       col, col):match("%s") == nil
    end

    local cmp = require 'cmp'

    cmp.setup({
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end
        },
        mapping = {
            ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
            ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
            ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
            ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
            ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
            ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
            ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
            ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
            ["<C-y>"] = cmp.config.disable,
            ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
            ['<CR>'] = cmp.mapping.confirm({
                select = false
            }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                local luasnip = require 'luasnip'
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, {"i", "s"}),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
                local luasnip = require 'luasnip'
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, {"i", "s"})
        },
        sources = {
            {
                name = 'nvim_lsp'
            }, {
                name = 'buffer',
                keyword_length = 5
            }, {
                name = 'luasnip'
            }, {
                name = 'nvim_lua'
            }, {
                name = 'path'
            }
        }
    })
end

M.luasnip = function()

    local luasnip = require('luasnip')
    luasnip.config.set_config {
        history = true,
        updateevents = "TextChanged,TextChangedI"
    }

    require("luasnip/loaders/from_vscode").lazy_load()
end

return M
