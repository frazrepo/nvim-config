return {
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        lazy = false,
        opts = function() 
           -- To generate this text : https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=FRAZ
           local logo = [[
           ███████╗██████╗  █████╗ ███████╗
           ██╔════╝██╔══██╗██╔══██╗╚══███╔╝
           █████╗  ██████╔╝███████║  ███╔╝ 
           ██╔══╝  ██╔══██╗██╔══██║ ███╔╝  
           ██║     ██║  ██║██║  ██║███████╗
           ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
           ]]
     
           logo = string.rep("\n", 8) .. logo .. "\n\n"
     
           local opts = {
             theme = "doom",
             hide = {
               -- this is taken care of by lualine
               -- enabling this messes up the actual laststatus setting after loading a file
               statusline = false,
             },
             config = {
               header = vim.split(logo, "\n"),
               -- stylua: ignore
               center = {
                 { action = 'lua require("telescope.builtin").find_files()',  desc = " Find File",       icon = " ", key = "f" },
                 { action = "ene | startinsert",                              desc = " New File",        icon = " ", key = "n" },
                 { action = 'lua require("telescope.builtin").oldfiles()',    desc = " Recent Files",    icon = " ", key = "r" },
                 { action = 'lua require("telescope.builtin").live_grep()',        desc = " Find Text",       icon = " ", key = "g" },
                 { action = 'Telescope projects',                             desc = " Restore Project", icon = " ", key = "p" },
                 { action = "Lazy",                                           desc = " Lazy",            icon = "󰒲 ", key = "l" },
                 { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit",            icon = " ", key = "q" },
               },
               footer = function()
                 local stats = require("lazy").stats()
                 local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                 return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
               end,
             },
           }
     
           for _, button in ipairs(opts.config.center) do
             button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
             button.key_format = "  %s"
           end
     
           -- open dashboard after closing lazy
           if vim.o.filetype == "lazy" then
             vim.api.nvim_create_autocmd("WinClosed", {
               pattern = tostring(vim.api.nvim_get_current_win()),
               once = true,
               callback = function()
                 vim.schedule(function()
                   vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
                 end)
               end,
             })
           end
     
           return opts
        end,
        dependencies = { {'nvim-tree/nvim-web-devicons'}}
      }
}