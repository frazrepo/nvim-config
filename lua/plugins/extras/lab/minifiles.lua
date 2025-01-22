return
{
    -- Usage : navigate using hjkl
    -- Manipalute file/dir creation like a normal buffer
    -- confirm operation with =
    -- Close dialog with q
    {
        'echasnovski/mini.files',
        version = '*',
        opts = {},
        keys = {
            {
                "<leader>fm",
                function()
                    require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
                end,
                desc = "Open mini.files (Directory of Current File)",
            },
            {
                "<leader>fM",
                function()
                    require("mini.files").open(vim.uv.cwd(), true)
                end,
                desc = "Open mini.files (cwd)",
            },
        },
    },
}
