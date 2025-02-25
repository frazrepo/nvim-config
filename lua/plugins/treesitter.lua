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
            incremental_selection = {
              enable = true,
              keymaps = {
                init_selection = "<CR>",
                node_incremental = "<CR>",
                scope_incremental = false,
                node_decremental = "<bs>",
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

    -- Autotags  and Autorename tags
    -- Need to install TreeSitter parser for html /xml :TSInstall html
    {
        'windwp/nvim-ts-autotag',
        event = "VeryLazy",
        config = function()
          require('nvim-ts-autotag').setup({
            opts = {
              -- Defaults
              enable_close = true, -- Auto close tags
              enable_rename = true, -- Auto rename pairs of tags
              enable_close_on_slash = true -- Auto close on trailing </
            },
            -- Also override individual filetype configs, these take priority.
            -- Empty by default, useful if one of the "opts" global settings
            -- doesn't work well in a specific filetype
            -- per_filetype = {
            --   ["html"] = {
            --     enable_close = false
            --   }
            -- }
          })
        end
    },
}
