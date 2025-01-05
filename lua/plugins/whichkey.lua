-----------------------------------------------------------
-- Whichkey configuration file
-- Plugin: whichkey
-- https://github.com/folke/which-key.nvim
-----------------------------------------------------------

-- which-key
return {
	"folke/which-key.nvim",
	config = function()
		require("which-key").setup({
			-- your configuration comes here
			-- or leave it empty to the default settings
			-- refer to the configuration section below
		})
		local wk = require("which-key")

		wk.add({
			{ "<leader>", group = "Leader" },
			{ "<leader>!", desc = "Delete buffer" },
			{ "<leader>,", desc = "Find buffer" },
			{ "<leader>/", desc = "Global Search" },
			{ "<leader>;", desc = "Find lines in buffer" },
			{ "<leader>G", desc = "Global Search in buffers" },
			{ "<leader>cd", desc = "Change to current buffer directory" },
			{ "<leader>d", desc = "Edit markdown buffer" },
			{ "<leader>e", desc = "Edit in current buffer path" },
			{ "<leader>fr", desc = "Find Replace Visually" },
			{ "<leader>kj", desc = "SplitJoin Join" },
			{ "<leader>kk", desc = "SplitJoin Toggle" },
			{ "<leader>ks", desc = "SplitJoin Split" },
			{ "<leader>m", desc = "Remove special char M" },
			{ "<leader>r", desc = "Replace Search Register" },
			{ "<leader>s", desc = "Edit sql buffer" },
			{ "<leader>te", desc = "Tab Edit in current buffer path" },
			{ "<leader>u", desc = "Open Recent File" },
			{ "<leader>w", desc = "Save buffer" },
			{ "<leader>x", desc = "Edit txt buffer" },
			{ "g", group = "Buffer" },
			{ "g=", desc = "Format buffer" },
			{ "gL", desc = "Go align left" },
			{ "gQ", desc = "Format buffer" },
			{ "gV", desc = "Reselect last pasted text" },
			{ "ga", desc = "Easy Align Operator" },
			{ "gb", desc = "Block Comment" },
			{ "gc", desc = "Comment" },
			{ "gl", desc = "Go align right" },
			{ "gq", desc = "Format" },
			{ "gs", desc = "Sort operator" },
			{ "gv", desc = "Reselect last visual selection" },
		})
	end,
}
