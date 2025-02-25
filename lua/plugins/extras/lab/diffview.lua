
return {
    {
        -- Source from here : https://www.naseraleisa.com/posts/diff
        -- Compare againt branch :DiffviewOpen HEAD..origin/master
        -- Compare againt branch :DiffviewOpen HEAD..origin/coc
        -- Compare againt local branch :DiffviewOpen master
        -- Compare againt local branch :DiffviewOpen coc
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
        keys = {
            { "<leader>gdd", desc = "Repo history" },
            { "<leader>gdf", desc = "File history" },
            { "<leader>gdl", desc = "Line/Range history" },
            { "<leader>gdc", desc = "Close DiffView" },
            { "<leader>gdm", desc = "Diff against master" },
            { "<leader>gdM", desc = "Diff against origin/master" },
            { "<leader>gdb", desc = "Diff against local branch" },
            { "<leader>gdB", desc = "Diff against remote branch" },
        },
        config = function(_,opts)
            require("diffview").setup(opts)
            vim.keymap.set( 'n', '<leader>gdd', '<cmd>DiffviewFileHistory<cr>', { desc = 'Repo history' })
            vim.keymap.set( 'n', '<leader>gdf', '<cmd>DiffviewFileHistory --follow %<cr>', { desc = 'File history' })
            vim.keymap.set( 'v', '<leader>gdl', "<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>", { desc = 'Range history' })
            vim.keymap.set( 'n', '<leader>gdl', '<Cmd>.DiffviewFileHistory --follow<CR>', { desc = 'Line history' })
            -- To Close, we can also just do a tab close :tabc
            vim.keymap.set( 'n', '<leader>gdc', '<cmd>set hidden<cr><cmd>DiffviewClose<cr><cmd>set nohidden<cr>', { desc = 'Close DiffView' })


            local function get_default_branch_name()
                local res = vim
                .system({ 'git', 'rev-parse', '--verify', 'main' }, { capture_output = true })
                :wait()
                return res.code == 0 and 'main' or 'master'
            end

            -- Diff against local master branch
            vim.keymap.set( 'n', '<leader>gdm', function() vim.cmd('DiffviewOpen ' .. get_default_branch_name()) end, { desc = 'Diff against master' })
            vim.keymap.set( 'n', '<leader>gdb', ':DiffviewOpen ', { desc = 'Diff against local branch' })
            vim.keymap.set( 'n', '<leader>gdB', ':DiffviewOpen HEAD..origin/', { desc = 'Diff against remote branch' })
            -- Diff against remote master branch
            vim.keymap.set(
            'n', '<leader>gdM', function() vim.cmd('DiffviewOpen HEAD..origin/' .. get_default_branch_name()) end, { desc = 'Diff against origin/master' })
        end

    }
}
