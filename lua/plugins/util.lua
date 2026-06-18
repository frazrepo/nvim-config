return  {
    -- fztips-nvim - Notes Collection for tips and tricks
    {
        "frazrepo/fztips-nvim",
        event = "VeryLazy"
    },

    {
        -- To suppress global warning "Undefined global vim variable" on lua files
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    -- vim gtfo - open files in terminal/explorer
    {
        'justinmk/vim-gtfo',
        lazy = true,
        keys = {
            { "gof", desc = "Open file in explorer" },
        },
    },
}
