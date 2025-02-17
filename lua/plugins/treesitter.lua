-----------------------------------------------------------
-- Plugin: nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter
-----------------------------------------------------------

-- treesitter interface : syntax highlighter
return {
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
        event = { "VeryLazy" },
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        opts = {
            -- ensure_installed = "maintained",
            -- Additional
            -- :TSInstall html
            -- :TSInstall c_sharp
            -- Check with :TSInstallInfo
            ensure_installed = {
                "lua",
                "markdown",
                "markdown_inline"
            },
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
            autotag = {
                enable = true,
                filetypes = { "html", "xml" },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
            },
        },
        config = function(_,opts)
            require("ts_context_commentstring").setup({})
        end,
	},
    -- TreeSitter context commentstring
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        event = "VeryLazy",
    },

    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        event = "VeryLazy",
    },

    -- Autotags 
    -- Need to install parser for html /xml :TSInstall html
    {
        'windwp/nvim-ts-autotag',
        ft = {
            "html",
            "xml",
        },
    },
}
