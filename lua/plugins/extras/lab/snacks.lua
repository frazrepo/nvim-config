return {
	-- Scratch buffer
	-- BigFile
	-- Zen Mode
	-- Indent
	{
		"folke/snacks.nvim",
        priority = 1000,
        lazy = false,
		opts = {
			bigfile = { enable = true },
			indent = { enable = true },
            lazygit = {enable = true},
            picker = { enable = true}
		},
		keys = {
            -- Zoom
			{ "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
			{ "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },

            -- Scratch
			{ "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
			{ "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },

            -- Lazygit
            { "<leader>gg", "<cmd>lua require'snacks'.lazygit()<CR>", desc = "LazyGit" },

            -- Search
            { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },
            { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep (Root Dir)" },
            { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep (Root Dir)" },
            { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
		},
	},
}
