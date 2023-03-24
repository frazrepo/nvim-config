-----------------------------------------------------------
-- Coc configuration file
-- Plugin: coc nvim
-- https://github.com/neoclide/coc.nvim
-----------------------------------------------------------
-- Useful Extensions
-- * Coc html
-- * Coc snippet + honza snippets
-- * Coc tsserver
-- * Coc powershell
-- * Coc yank
-- * Coc json
-- * Coc yaml
-- * Coc markdown lint
-- * Coc tab nine AI coding experience
-- * Coc sql
-- * Coc omnisharp
-- * Coc snippets + honza snippets
-- * Coc lua
--
-- Inspiration from
-- https://github.com/albingroen/quick.nvim/blob/main/lua/coc-config.lua

local exec = vim.api.nvim_exec 	        -- execute Vimscript

vim.api.nvim_set_keymap("n", "<leader>.", "<Plug>(coc-codeaction)", {})
vim.api.nvim_set_keymap("n", "<leader>ca","<Plug>(coc-codeaction)", {})
vim.api.nvim_set_keymap("n", "<leader>l", ":CocCommand eslint.executeAutofix<CR>", {})
vim.api.nvim_set_keymap("n", "gd", "<Plug>(coc-definition)", {silent = true})
vim.api.nvim_set_keymap("n", "K", ":call CocActionAsync('doHover')<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>rn", "<Plug>(coc-rename)", {})
vim.api.nvim_set_keymap("n", ",f", ":CocCommand prettier.formatFile<CR>", {noremap = true})

vim.api.nvim_set_keymap("i", "<C-Space>", "coc#refresh()", { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<TAB>", "pumvisible() ? '<C-n>' : '<TAB>'", {noremap = true, silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<S-TAB>", "pumvisible() ? '<C-p>' : '<C-h>'", {noremap = true, expr = true})
vim.api.nvim_set_keymap("i", "<CR>", "pumvisible() ? coc#_select_confirm() : '<C-G>u<CR><C-R>=coc#on_enter()<CR>'", {silent = true, expr = true, noremap = true})


-- Coc yank
vim.api.nvim_set_keymap("n", "<leader>y",":<C-u>CocList -A --normal yank<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>yc",":CocCommand yank.clean<cr>", {noremap = true, silent = true})

--Snippets
-- https://github.com/noclide/coc-snippets
exec([[
    " Use <C-l> for trigger snippet expand.
    imap <C-l> <Plug>(coc-snippets-expand)

    " Use <C-j> for select text for visual placeholder of snippet.
    vmap <C-j> <Plug>(coc-snippets-select)

    " Use <C-j> for jump to next placeholder, it's default of coc.nvim
    let g:coc_snippet_next = '<c-j>'

    " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
    let g:coc_snippet_prev = '<c-k>'

    " Use <C-j> for both expand and jump (make expand higher priority.)
    imap <C-j> <Plug>(coc-snippets-expand-jump)]]
,false)

-----------------------------------------------------------
-- Applications & Plugins shortcuts:
-----------------------------------------------------------kG

-- -- Coc yank
vim.api.nvim_set_keymap("n", "<leader>y",":<C-u>CocList -A --normal yank<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>yc",":CocCommand yank.clean<cr>", {noremap = true, silent = true})



-- AutoCommands for powershell bindings
exec([[
        augroup psbindings
            autocmd! psbindings
            autocmd Filetype ps1 nnoremap <buffer> <F8> :CocCommand powershell.evaluateLine<CR>
            autocmd Filetype ps1 vnoremap <buffer> <F8> :CocCommand powershell.evaluateSelection<CR>
            autocmd Filetype ps1 nnoremap <buffer> <F5> :CocCommand powershell.execute<CR>
        augroup end
 ]], false)

-- TODO : convert to lua autogroup/autocommand
-- https://alpha2phi.medium.com/neovim-for-beginners-lua-autocmd-and-keymap-functions-3bdfe0bebe42
--  local psBindingGrp = vim.api.nvim_create_augroup("psbinding", { clear = true })
--  vim.api.nvim_create_autocmd(
--     "FileType",
--     { pattern = {"ps1"},
--       command =  [[ nnoremap <buffer> <F8> :CocCommand powershell.evaluateLine<CR> ]],
--       group = psBindingGrp
--     }
--  )
