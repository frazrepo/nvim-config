-----------------------------------------------------------
-- Code Helpers - Code Generation
-----------------------------------------------------------
return
{
    -----------------------------------------------------------
    -- Autorename, Autopair, Autotag
    -----------------------------------------------------------
    -- Autorename tags
    {
        'AndrewRadev/tagalong.vim',
        ft = {
            "html",
            "xml",
            "jsx",
            "tsx",
            "javascriptreact",
            "typescriptreact",
        },
    },

    -- Autopairs
    -- {
    --     'windwp/nvim-autopairs',
    --     event = { "InsertEnter" },
    --     opts = {}
    -- },
    -- auto pairs
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {
            modes = { insert = true, command = true, terminal = false },
            -- skip autopair when next character is one of these
            skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
            -- skip autopair when the cursor is inside these treesitter nodes
            skip_ts = { "string" },
            -- skip autopair when next character is closing pair
            -- and there are more closing pairs than opening pairs
            skip_unbalanced = true,
            -- better deal with markdown code blocks
            markdown = true,
        },
    },
    -----------------------------------------------------------
    -- Text objects
    -----------------------------------------------------------
    {
        'coderifous/textobj-word-column.vim',
        event = { "BufReadPost" },
    },
    {
        'michaeljsmith/vim-indent-object',
        event = { "BufReadPost" },
    },
    {
        -- See here configuration
        -- https://github.com/LazyVim/LazyVim/blob/1e83b4f843f88678189df81b1c88a400c53abdbc/lua/lazyvim/plugins/coding.lua#L45
        'echasnovski/mini.ai',
        version = '*',
        event = { "BufReadPost" },
        opts = {}
    },
    -----------------------------------------------------------
    -- Emmet configuration file
    -- html/css snippets
    -----------------------------------------------------------
    {
        "mattn/emmet-vim",
        ft = {
            "html",
            "css",
            "typescript",
            "typescriptreact",
            "javascriptreact",
            "javascript",
        },
        config = function()
            -- vim.g.user_emmet_leader_key = "<C-Z>"
            vim.keymap.set("i", "<C-e>", "<Plug>(emmet-expand-abbr)", {remap = true})
            vim.keymap.set("n", ")e", "<Plug>(emmet-move-next)", {remap = true})
            vim.keymap.set("n", "(e", "<Plug>(emmet-move-prev)", {remap = true})
        end,
    }
}
