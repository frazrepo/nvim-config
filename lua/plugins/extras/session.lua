return {
    -- Alternative neovim session manager
    -- bug avec des splits ? : works after restart
    -- Another bug: seems to not working correctly when switching between sessions
    {
        "shatur/neovim-session-manager",
        config = function()
            require('session_manager').setup({
                autoload_mode = require('session_manager.config').AutoloadMode.Disabled,             })
            vim.api.nvim_set_keymap("n", "<leader>as", "<Cmd>SessionManager load_session<CR>", {noremap = true, silent = true})
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
            vim.api.nvim_set_keymap("n", "<leader>aa", "<Cmd>Telescope possession list<CR>", {noremap = true, silent = true})
            vim.api.nvim_set_keymap("n", "<leader>an", ":<C-u>SSave ", {noremap = true, silent = false})
        end,
   },

}