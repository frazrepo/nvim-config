return {
	-- splitjoin with treesitter functions
	-- mapping conflict with <leader>s , sql buffer
	-- kk : toggle, kj : join, ks : split
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({
				use_default_keymaps = false,
			})
		end,
		keys = {
			{ "<leader>kk", function() require("treesj").toggle() end,  desc = "SplitJoin Toggle" },
			{ "<leader>kj", function() require("treesj").join() end,  desc = "SplitJoin Join" },
			{ "<leader>ks", function() require("treesj").split() end,  desc = "SplitJoin Split" }
		}
	},
}
