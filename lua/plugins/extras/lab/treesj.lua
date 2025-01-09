return {
	-- splitjoin
	-- mapping conflict with <leader>s , sql buffer
	-- kk : toggle, kj : join, ks : split
	{
		"Wansmer/treesj",
		keys = { "<space>kk", "<space>kj", "<space>ks" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({
				use_default_keymaps = false,
			})
			-- For use default preset and it work with dot
			vim.keymap.set("n", "<leader>kk", require("treesj").toggle, { silent = false, desc = "SplitJoin Toggle" })
			vim.keymap.set("n", "<leader>kj", require("treesj").join, { desc = "SplitJoin Join" })
			vim.keymap.set("n", "<leader>ks", require("treesj").split, { desc = "SplitJoin Split" })
		end,
	},
}
