-----------------------------------------------------------
-- Floaterm configuration file
-- Plugin: nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter
-----------------------------------------------------------

-- treesitter interface : syntax highlighter
return {
	"nvim-treesitter/nvim-treesitter",
	run = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			-- ensure_installed = "maintained",
			-- Additional
			-- :TSInstall html
			-- :TSInstall c_sharp
			-- Check with :TSInstallInfo
			ensure_installed = {
				"lua",
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
		})

		require("ts_context_commentstring").setup({})
	end,
}
