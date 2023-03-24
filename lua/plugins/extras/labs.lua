
-- or to disable to file
if true then return {} end

return {
    -- easily jump to any location and enhanced f/t motions for Leap
    {
    "ggandor/flit.nvim",
    keys = function()
      ---@type LazyKeys[]
      local ret = {}
      for _, key in ipairs({ "f", "F", "t", "T" }) do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
    },

    -- splitjoin
    -- mapping conflict with <leader>s , sql buffer
    -- {
    --     'Wansmer/treesj',
    --     keys = { '<space>m', '<space>j', '<space>s' },
    --     dependencies = { 'nvim-treesitter/nvim-treesitter' },
    --     config = function()
    --         require('treesj').setup({--[[ your config ]]})
    --     end,
    -- },


    -- hop (better and simpler than lightspeed) Need more experimentation
    -- {
    --     'phaazon/hop.nvim',
    --     branch = 'v1', -- optional but strongly recommended
    --     event = "BufRead",
    --     cmd = {"HopChar2", "HopWord"},
    --     config = function()
    --         -- you can configure Hop the way you like here; see :h hop-config
    --         require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    --         -- vim.api.nvim_set_keymap('n', 's', "<cmd>lua require('hop').hint_words()<cr>", {})
    --         vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
    --         vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    --
    --     end
    -- }

}