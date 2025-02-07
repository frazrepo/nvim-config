
return {
    {
        -- Source from here : https://www.naseraleisa.com/posts/diff
        "sindrets/diffview.nvim",
        config = function(_,opts)
            require("diffview").setup(opts)
            vim.keymap.set( 'n', '<leader>ghh', '<cmd>DiffviewFileHistory<cr>', { desc = 'Repo history' })
            vim.keymap.set( 'n', '<leader>ghf', '<cmd>DiffviewFileHistory --follow %<cr>', { desc = 'File history' })
            vim.keymap.set( 'v', '<leader>ghl', "<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>", { desc = 'Range history' })
            vim.keymap.set( 'n', ',<leader>ghl', '<Cmd>.DiffviewFileHistory --follow<CR>', { desc = 'Line history' })
            -- To Close, we can also just do a tab close :tabc
            vim.keymap.set( 'n', '<leader>ghc', '<cmd>set hidden<cr><cmd>DiffviewClose<cr><cmd>set nohidden<cr>', { desc = 'Close DiffView' })


            local function get_default_branch_name()
                local res = vim
                .system({ 'git', 'rev-parse', '--verify', 'main' }, { capture_output = true })
                :wait()
                return res.code == 0 and 'main' or 'master'
            end

            -- Diff against local master branch
            vim.keymap.set( 'n', '<leader>ghm', function() vim.cmd('DiffviewOpen ' .. get_default_branch_name()) end, { desc = 'Diff against master' })
            -- Diff against remote master branch
            vim.keymap.set(
            'n', '<leader>ghM', function() vim.cmd('DiffviewOpen HEAD..origin/' .. get_default_branch_name()) end, { desc = 'Diff against origin/master' })
        end

    }
}
