-- or to disable to file

if true then return {}
end

return {
    -- Alternative neovim session manager
    -- bug avec des splits ? : works after restart
    -- Another bug: seems to not working correctly when switching between sessions
    {
        "shatur/neovim-session-manager",
        config = function()
            require('session_manager').setup({
                autoload_mode = require('session_manager.config').AutoloadMode.Disabled,             })
                vim.keymap.set("n", "<leader>as","<Cmd>SessionManager load_session<CR>", { silent = true, desc = "SessionManager LoadSession" })
        end,
        dependencies = {'stevearc/dressing.nvim'}
    },

   -- Alternative : possession
   -- Commands : Possession* or Alias S*
   -- Telescope integration : :Telescope possession list
   -- Bug : switching session keeps old buffers open
   {
        'jedrzejboczar/possession.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            -- setup
            require('possession').setup({
                autosave = {
                    current = true,
                    -- tmp = true,
                    -- tmp_name = 'tmp',
                    on_load = true,
                    on_quit = true,
                },
                commands = {
                    save = "SSave",
                    load = "SLoad",
                    delete = "SDelete",
                    list = "SList",
                },
            })
            -- telescope integration
            require('telescope').load_extension('possession')
            vim.keymap.set("n", "<leader>aa", "<Cmd>Telescope possession list<CR>", { desc = "Telescope Possession List", silent = true })
            vim.keymap.set("n", "<leader>an", ":<C-u>SSave ", { desc = "Possession Save Session", silent = false })
        end,
        -- doesn't show on which-key when not loaded
        keys = {
            { "<leader>aa"},
            { "<leader>an"},
        },
   },

}
