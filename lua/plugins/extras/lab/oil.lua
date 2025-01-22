return 
{
    -- Usage : navigate parent directory using -
    -- Manipulate file/directory like a normal buffer
    -- Switch batch to last buffer using standard vim commande (Backspace in thi config)
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
        config = function ()
            require("oil").setup()
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })   
        end
    }
}
