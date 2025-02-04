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

            --File
            { "<leader>fi", function() Snacks.picker.explorer() end, desc = "Find Files", mode = { "n", "x" } },
            { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
            { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },

            -- Scratch
			{ "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
			{ "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },

            -- Lazygit
            { "<leader>gg", "<cmd>lua require'snacks'.lazygit()<CR>", desc = "LazyGit" },
            -- git
            { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
            { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
            { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },

            -- Search
            { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },
            { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep (Root Dir) like <leader>/" },
            { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep (Root Dir)" },
            -- { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
            -- { "<leader>s;", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
            { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
            -- Additional search
            -- search
            { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
            { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
            { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
            { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
            { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
            { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
            { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
            { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
            -- like command palette C-P
            { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
            { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
            -- ui
            { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
		},
	},
    -- {
    --   "folke/todo-comments.nvim",
    --   optional = true,
    --   keys = {
    --     { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
    --     { "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    --   },
    -- }
}
