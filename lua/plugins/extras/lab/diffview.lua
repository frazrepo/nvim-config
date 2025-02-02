
return {
    {
        -- Source from here : https://www.naseraleisa.com/posts/diff
        "sindrets/diffview.nvim",
        config = function(_,opts)
            require("diffview").setup(opts)
            vim.keymap.set( 'n', ',hh', '<cmd>DiffviewFileHistory<cr>', { desc = 'Repo history' })
            vim.keymap.set( 'n', ',hf', '<cmd>DiffviewFileHistory --follow %<cr>', { desc = 'File history' })
            vim.keymap.set( 'v', ',hl', "<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>", { desc = 'Range history' })
            vim.keymap.set( 'n', ',hl', '<Cmd>.DiffviewFileHistory --follow<CR>', { desc = 'Line history' })
            vim.keymap.set( 'n', ',hc', '<Cmd>.DiffviewClose<CR>', { desc = 'Close DiffView' })

            local function get_default_branch_name()
                local res = vim
                .system({ 'git', 'rev-parse', '--verify', 'main' }, { capture_output = true })
                :wait()
                return res.code == 0 and 'main' or 'master'
            end

            -- Diff against local master branch
            vim.keymap.set( 'n', ',hm', function() vim.cmd('DiffviewOpen ' .. get_default_branch_name()) end, { desc = 'Diff against master' })
            -- Diff against remote master branch
            vim.keymap.set(
            'n', ',hM', function() vim.cmd('DiffviewOpen HEAD..origin/' .. get_default_branch_name()) end, { desc = 'Diff against origin/master' })


            -- Highlight changed words.
            vim.keymap.set( 'n', ',vw', require('gitsigns').toggle_word_diff, { desc = 'Toggle word diff' })
            -- Highlight added lines.
            vim.keymap.set( 'n', ',vL', require('gitsigns').toggle_linehl, { desc = 'Toggle line highlight' })
            -- Highlight removed lines.
            vim.keymap.set( 'n', ',vv', require('gitsigns').toggle_deleted, { desc = 'Toggle deleted (all)' })
        end

    }
}
