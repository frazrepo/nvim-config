
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
			index = { enable = true },
		},
		keys = {
			{ "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
			{ "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
			{ "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
			{ "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
		},
	},
}