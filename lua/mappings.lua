-----------------------------------------------------------
-- Mappings configuration file
-----------------------------------------------------------
-----------------------------------------------------------
-- Vim aliases
-----------------------------------------------------------

local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true  }
local cmd = vim.cmd

-- Leader space
vim.g.mapleader = " "

-----------------------------------------------------------
-- Mappings
-----------------------------------------------------------

-- Clear search highlighting
map('', '<space><space>', ':nohl<CR>', {silent = true})

-- Fast saving
map('n', '<leader>w', ':w!<CR>', {noremap =false, silent = true})
map('n', '<C-S>', ':update<CR>', {noremap =false, silent = true})
map('v', '<C-S>', '<C-C>:update<CR>', {noremap =false, silent = true})
map('i', '<C-S>', '<C-O>:update<CR>', {noremap =false, silent = true})

-- Map jk to ESC in insert mode
map('i', 'jk', '<Esc>', {noremap = true})

-- Repeat . command in visual mode
map('v', '.', ':normal.<CR>', {noremap = true})

-- Keep selection in select mode after shifting
-- Indenting not working when the line starts with ##
map('v', '>', '>gv', default_opts)
map('v', '<', '<gv', default_opts)

-- " Reselect last insertext
map('n', 'gV','`[v`]', default_opts)

-- Smart way to move between windows horizontally
map('n', '<C-h>','<C-W>h', {noremap =false, silent = true})
map('n', '<C-l>','<C-W>l', {noremap =false, silent = true})
map('n', '<C-j>','<C-W>j', {noremap =false, silent = true})
map('n', '<C-k>','<C-W>k', {noremap =false, silent = true})

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { noremap =false, silent = true })
map("n", "<C-Down>", "<cmd>resize -2<cr>", {noremap =false, silent = true })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { noremap =false, silent = true })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", {noremap =false, silent = true })

-- Move faster vertically (paragraph motion) (Replaced with windows navigation)
-- map('n', '<C-j>','}', {noremap =false, silent = true})
-- map('n', '<C-k>','{', {noremap =false, silent = true})

-- Switch CWD to the directory of the open buffer
map('n', '<leader>cd',':cd %:p:h<cr>:pwd<cr>', {noremap =false, silent = true})

-- Close the current buffer
map('n', '<leader>bd',':bd<cr>', {noremap =false, silent = true})
map('n', '<leader>!',':bd!<cr>', {noremap =false, silent = true})

-- Useful mapping for managing  buffers
map('n', '<leader>bn','<Cmd>enew<cr>', {noremap =false, silent = true})
map('n', '<leader>ba',':bufdo bd<cr>', {noremap =false, silent = true})

-- Backspace to navigate to alternate buffer
map('n', '<bs>','<c-^>', {noremap =false, silent = true})

-- Edit quickly with the current buffer path
map('n', '<leader>e',':edit <c-r>=expand("%:p:h")<cr>/', {noremap =false, silent = true})

-- Change word under cursor and dot repeat, really useful to edit quickly
map('n', 'c*' , '*Ncgn' , default_opts)
map('n', 'c#' , '#NcgN' , default_opts)
map('n', 'cg*', 'g*Ncgn', default_opts)
map('n', 'cg#', 'g#Ncgn', default_opts)

-- Experimental cn - New mappings
-- like c* but selection word in visual mode first
map('n', 'cn' , '*``cgn' , default_opts)
vim.cmd([[
        let g:mc = "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>"
        vnoremap <expr> cn g:mc . "``cgn"
    ]]
)

-- " Quick yanking to the end of the line
map('n', 'Y', 'y$', default_opts)

-- " Quick macro recording and replaying ,qq for recording, and Q for replaying
map('n', 'Q', '@q', default_opts)
map('x', 'Q', ':normal @q<CR>', default_opts)

-- Execute a macro over a visual range
map('x', '@',[[:<C-u>call ExecuteMacroOverVisualRange()<CR>]], default_opts)

-- " Indent/Format All documents using = or gq
map('n', 'g=','mmgg=G`m', default_opts)
map('n', 'gQ','mmgggqG`m', default_opts)

-- Insert new line in normal mode quickly and move cursor (but not in quickfix window or in command line history)
map('n', '<CR>', [[&buftype ==# 'nofile' ? "\<CR>" : &buftype ==# 'quickfix' ? "\<CR>" : ":set paste<CR>o<Esc>:set nopaste<CR>"]]  , {noremap =false, silent = true, expr = true})
map('n', '<S-CR>', ':set paste<CR>O<Esc>:set nopaste<CR>', default_opts)

-- Navigating quickfix (Experimental)
map('n', '<A-Down>','<Cmd>cnext<Cr>', default_opts)
map('n', '<A-Up>','<Cmd>cprevious<Cr>', default_opts)
map('n', '<M-Down>','<Cmd>cnext<Cr>', default_opts)
map('n', '<M-Up>','<Cmd>cprevious<Cr>', default_opts)

-- H and L Begin/End on homerow
map('n', 'H', '^'  , {noremap =false, silent = true})
map('n', 'L', 'g_'  , {noremap =false, silent = true})

-- Paste quickly in insert mode
map('i', '<C-r><C-r>','<C-r>*', default_opts)

-- " Enhance paste in visual mode to replace many times with the yank register
map('x', 'p',[[p:if v:register == '+'<Bar>let @+=@0<Bar>endif<CR>]], default_opts)

-- Do not track every j and k motion in jumplist
map('n', 'k', [[(v:count > 1 ? "m'" . v:count : '') . 'gk']]  , {noremap =true, silent = true, expr = true})
map('n', 'j', [[(v:count > 1 ? "m'" . v:count : '') . 'gj']]  , {noremap =true, silent = true, expr = true})

-- Toogle gj gk and j k
map('n', 'gj','j', default_opts)
map('n', 'gk','k', default_opts)

-- Map some keys for azerty keyboard
map('n', 'µ', '#'  , {noremap =false, silent = true})
map('n', '²', '.'  , {noremap =false, silent = true})

-- Marks keepjumps
map('n', 'mù','m`', default_opts)
map('n', 'ùù','``', default_opts)
map('n', '\'','`', default_opts)

-- -- Increment / Decrement
map('n', '+','<C-a>', default_opts)
map('n', '-','<C-x>', default_opts)
map('x', '+','<C-a>', default_opts)
map('x', '-','<C-x>', default_opts)

-- For unimpaired
map('n', ')',']', {noremap =false, silent = true})
map('n', '(','[', {noremap =false, silent = true})
map('o', '(','[', {noremap =false, silent = true})
map('o', ')',']', {noremap =false, silent = true})
map('x', '(','[', {noremap =false, silent = true})
map('x', ')',']', {noremap =false, silent = true})

-- Undo breakpoints
map('i', ',', ',<c-g>u', default_opts)
map('i', '.', '.<c-g>u', default_opts)
map('i', '!', '!<c-g>u', default_opts)
map('i', '?', '?<c-g>u', default_opts)

-- " Expand %% to current path in command line mode ( not working with <leader>fr
map('c', '%%', [[<C-R>=fnameescape(expand("%:p:h")) . '/'<CR>]]  , {noremap =false, silent = true})
map('c', '::', [[<C-R>=fnameescape(expand("%"))<CR>]]  , {noremap =false, silent = true})

-- Remove the Windows ^M - when the encodings gets messed up
map('n', '<Leader>m', [[mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm]]  , {noremap =false, silent = true})

-- -- terminal mapping
function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-p>', [[<C-R>*]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

------------------------------------------------------------
-- Text-Objects
------------------------------------------------------------

-- All Object Ex : yA
-------------------
map('o', 'A',':<c-u>normal! ggVG<cr>', default_opts)

-- Line text-object
-------------------
-- il al
map('x', 'il','g_o0', default_opts)
map('o', 'il',':<C-u>normal vil<CR>', default_opts)
map('x', 'al','$o0', default_opts)
map('o', 'al',':<C-u>normal val<CR>', default_opts)


-- Buffer(entire) text-object
-----------------------------
-- ie ae
map('x', 'ie','GoggV', default_opts)
map('o', 'ie',':<C-u>normal mzvie<CR>`z', default_opts)
map('x', 'ae','GoggV', default_opts)
map('o', 'ae',':<C-u>normal mzvae<CR>`z', default_opts)


-- Right Angle and Angle Bracket text-object
---------------------------------------------
-- ir ar
map('x', 'ir','i[', default_opts)
map('o', 'ir',':<C-u>normal vi[<CR>', default_opts)
map('x', 'ar','a[', default_opts)
map('o', 'ar',':<C-u>normal va[<CR>', default_opts)

-- " ia aa
map('x', 'ia','i>', default_opts)
map('o', 'ia',':<C-u>normal vi><CR>', default_opts)
map('x', 'aa','a>', default_opts)
map('o', 'aa',':<C-u>normal va><CR>', default_opts)

------------------------------------------------------------
-- Search and Replace normal and visual mode
------------------------------------------------------------
-- search replace
map("n", "<leader>fr",":%s/", default_opts)
map("x", "<leader>fr",[[:s/]], default_opts)

map('n', '<leader>r',[[:%s///g<Left><Left>]], {noremap = true, silent = false})

-- Visual mode pressing * or # searches for the current selection
map("x", "*",[[:<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>]], default_opts)
map("x", "#",[[:<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>]], default_opts)

-- Search and replace the selected text
map("x", "<leader>r",[[:call VisualSelection('replace','')<CR>]], default_opts)

-----------------------------------------------------------
-- Miscellaneous
-----------------------------------------------------------

-- Toogle quickfix windows
map("n", "<F8>",":call QuickFixToggle()<cr>", default_opts)

-- Quickly open a txt, markdown and sql buffer for scribble
map("n", "<leader>x",":e ~/buffer.txt<CR>", default_opts)
map("n", "<leader>d",":e ~/buffer.md<CR>", default_opts)
map("n", "<leader>s",":e ~/buffer.sql<CR>", default_opts)


-- Map for navigating search (/?) result
vim.cmd([[
        set wildcharm=<C-z>
        cnoremap <expr> <Tab> getcmdtype() =~ '[\/?]' ? "<C-g>" : "<C-z>"
        cnoremap <expr> <S-Tab> getcmdtype() =~ '[\/?]' ? "<C-t>" : "<S-Tab>"
    ]]
)
