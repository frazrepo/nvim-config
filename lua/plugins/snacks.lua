return {
	-- Scratch buffer
	-- BigFile
	-- Zen Mode
	-- Indent
  -- Terminal (see terminal.lua)
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enable = true },
      indent = { enable = true },
      lazygit = {enable = true},
      picker = { enable = true},
      explorer = { enable = true},
    },
    keys = {
      -- Zoom
      { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
      { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
      
      -- Buffers
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Find buffer" },

      --File
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Search Files" },
      { "<leader><leader>", function() Snacks.picker.files() end, desc = "Search Files" },
      { "<C-p>", function() Snacks.picker.files() end, desc = "Search Files" },
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },

      -- Scratch
      { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },

      -- Lazygit and git
      { "<leader>gg", function() Snacks.lazygit() end , desc = "LazyGit" },
      { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },

      -- Search
      { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep (Root Dir) like <leader>/" },
      { "<C-F>", function() Snacks.picker.grep() end, desc = "Grep (Root Dir) like <leader>/" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep (Root Dir)" },
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>;", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
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
      { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },

      -- ui
      { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },

      -- projects
      { "<leader>p", function() Snacks.picker.projects() end, desc = "Projects" },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },

    -- Explorer
      {
        "<leader>fe",
        function()
          Snacks.explorer()
        end,
        desc = "Explorer Snacks (cwd)",
      },
      {
        "<leader>fE",
        function()
          Snacks.explorer({ cwd = FrazVim.root() })
        end,
        desc = "Explorer Snacks (root)",
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    opts = {},
    --  optional = true,
    keys = {
        { ")t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
        { "(t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
        -- Other command: TodoQuickFix
        -- { "<leader>xt", "<cmd>TodoTelescope<cr>", desc = "Todo" },
        -- { "<leader>xT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
        { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
        { "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
        },
      }
  }
