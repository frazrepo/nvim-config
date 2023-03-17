-----------------------------------------------------------
-- Plugin manager configuration file
-- Plugin manager: lazy.nvim
-- https://github.com/folke/lazy.nvim
-----------------------------------------------------------
--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

local fzconfig = require("fzconfig")

require("lazy").setup({
-----------------------------------------------------------
-- Buffer Helpers
-----------------------------------------------------------
    -- tim pope plugins (ko ?)
    'tpope/vim-surround',

    --  repeat surround action
    'tpope/vim-repeat',

    -- vim-exchange exchange lines
    {
        "tommcdo/vim-exchange",
        keys = {
            { "cx" },
            { "X" , mode = "x" },
        },
    },

    -- transpose
    -- If not working on *unix
    -- Convert plugin/transpose.vim and autoload/transpose.vim with dos2unix
    {
        "vim-scripts/Transpose",
        cmd = {
            "Transpose", "TransposeWords", "TransposeCSV", "TransposeTab", "TransposeInteractive"
        },
    },

    -- Align based on character (mapping gl)
    {
        'tommcdo/vim-lion',
        keys = {
            { "gl" },
            { "gl" , mode = "x" },
        },
    },

    -- Aligning (mapping ga , replace gl when config is stable)
    {
        "junegunn/vim-easy-align",
        config = function()
            -- require "rmagatti.easyalign"
            vim.cmd [[
                " Start interactive EasyAlign in visual mode (e.g. vipga)
                xmap ga <Plug>(EasyAlign)
                " Start interactive EasyAlign for a motion/text object (e.g. gaip)
                nmap ga <Plug>(EasyAlign)
                " Align GitHub-flavored Markdown tables
                augroup aligning
                au!
                au FileType markdown vmap <leader><Bslash> :EasyAlign*<bar><CR>
                augroup end
                ]]
        end,
        keys = {
            { "ga" },
            { "ga" , mode = "x" },
        },
        cmd = { "EasyAlign" },
    },

    -- vim-sort-motion (mapping gs)
    {
        "christoomey/vim-sort-motion",
        keys = {
            { "gss" },
            { "gs" },
            { "gs" , mode = "x" },
        },
    },

    -- Replace with Register
    {
        'vim-scripts/ReplaceWithRegister'
    },

    -- Text objects
    { 'coderifous/textobj-word-column.vim' },
    { 'michaeljsmith/vim-indent-object' },
    {
        "wellle/targets.vim",
        event = { "BufReadPost" },
    },

-- Helpers
-----------------------------------------------------------
    -- lightspeed (Advantage : the label is on the third char)
    {
        'ggandor/lightspeed.nvim',
        config = function()
            require 'lightspeed'.setup {
                labels = { "s", "f", "n", "j", "k", "l", "o", "i", "w", "e", "h", "g", "u", "t", "m", "v", "c", "a", "z" }
            }

            --disabling f F t T
            vim.api.nvim_set_keymap("n", "f", "f", { silent = true })
            vim.api.nvim_set_keymap("n", "F", "F", { silent = true })
            vim.api.nvim_set_keymap("n", "t", "t", { silent = true })
            vim.api.nvim_set_keymap("n", "T", "T", { silent = true })

        end
    },
 })
