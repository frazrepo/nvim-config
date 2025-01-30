-----------------------------------------------------------
-- Mappings configuration file
-----------------------------------------------------------

-----------------------------------------------------------
-- Vim aliases
-----------------------------------------------------------

local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true  }

-- Leader space
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-----------------------------------------------------------
-- Mappings
-----------------------------------------------------------

-- Clear search highlighting
vim.keymap.set('n', '<esc>', FrazVim.ClearSearchHLAndStopSnippet, { noremap = false, silent = true, expr = true })
vim.keymap.set('i', '<esc>', FrazVim.ClearSearchHLAndStopSnippet, { noremap = false, silent = true, expr = true })
vim.keymap.set('v', '<esc>', FrazVim.ClearSearchHLAndStopSnippet, { noremap = false, silent = true, expr = true })

-- Save file
map('n', '<C-s>', '<cmd>w<cr><esc>', {noremap =false, silent = true})
map('x', '<C-s>', '<cmd>w<cr><esc>', {noremap =false, silent = true})
map('i', '<C-s>', '<cmd>w<cr><esc>', {noremap =false, silent = true})
map('s', '<C-s>', '<cmd>w<cr><esc>', {noremap =false, silent = true})

-- Repeat . command in visual mode
map('v', '.', ':normal.<CR>', {noremap = true})

-- Keep selection in select mode after shifting
-- Indenting not working when the line starts with ##
map('v', '>', '>gv', default_opts)
map('v', '<', '<gv', default_opts)

-- " Reselect last pasted text
map('n', 'gV','`[v`]',  { noremap = true, silent = true , desc = "Reselect last pasted text" })

-- Smart way to move between windows horizontally - See wezterm plugin
-- map('n', '<C-h>','<C-W>h', {noremap =false, silent = true})
-- map('n', '<C-l>','<C-W>l', {noremap =false, silent = true})
-- map('n', '<C-j>','<C-W>j', {noremap =false, silent = true})
-- map('n', '<C-k>','<C-W>k', {noremap =false, silent = true})

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { noremap =false, silent = true })
map("n", "<C-Down>", "<cmd>resize -2<cr>", {noremap =false, silent = true })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { noremap =false, silent = true })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", {noremap =false, silent = true })


-- Switch CWD to the directory of the open buffer
map('n', '<leader>cd',':cd %:p:h<cr>:pwd<cr>', {noremap =false, silent = true, desc = "Change to current buffer directory"})

-- Useful mapping for managing  buffers
map('n', '<leader>!',':bd!<cr>', {noremap =false, silent = true, desc = "Delete buffer"})
map('n', '<leader>bd',':bd<cr>', {noremap =false, silent = true, desc = "Delete buffer"})
map('n', '<leader>bn','<Cmd>enew<cr>', {noremap =false, silent = true, desc = "New buffer"})
map('n', '<leader>ba',':bufdo bd<cr>', {noremap =false, silent = true, desc = "Delete all buffers"})
map('n', '<leader>bo',':silent! execute "%bd|e#|bd#"<cr>', {noremap =false, silent = true, desc = "Keep only current buffer"})

-- Backspace to navigate to alternate buffer
map('n', '<bs>','<c-^>', {noremap =false, silent = true})

-- Edit quickly with the current buffer path
map('n', '<leader><leader>e',':edit <c-r>=expand("%:p:h")<cr>/', {noremap =false, silent = true, desc = "Edit in current buffer path"})

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

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
map('x', '@',[[:<C-u>lua FrazVim.ExecuteMacroOverVisualRange()<CR>]], default_opts)

-- " Indent/Format All documents using = or gq
map('n', 'g=','mmgg=G`m',  { noremap = true, silent = true , desc = "Indent buffer" })
map('n', 'gQ','mmgggqG`m',  { noremap = true, silent = true , desc = "Format buffer" })

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

-- Alternative to unimpaired )or ( <Space> (from mini.bascis)
-- map('n', 'gO', 'v:lua.MiniBasics.put_empty_line(v:true)',  { expr = true, desc = 'Put empty line above' })
-- map('n', 'go', 'v:lua.MiniBasics.put_empty_line(v:false)', { expr = true, desc = 'Put empty line below' })
vim.keymap.set('n', 'gO', "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>")
vim.keymap.set('n', 'go', "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>")

-- Undo breakpoints
map('i', ',', ',<c-g>u', default_opts)
map('i', '.', '.<c-g>u', default_opts)
map('i', '!', '!<c-g>u', default_opts)
map('i', '?', '?<c-g>u', default_opts)

-- " Expand %% to current path in command line mode ( not working with <leader>fr
map('c', '%%', [[<C-R>=fnameescape(expand("%:p:h")) . '/'<CR>]]  , {noremap =false, silent = true})
map('c', '::', [[<C-R>=fnameescape(expand("%"))<CR>]]  , {noremap =false, silent = true})

-- Remove the Windows ^M - when the encodings gets messed up
map('n', '<Leader>m', [[mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm]]  , {noremap =false, silent = true, desc = "Remove special char ^M"})

-- Windows
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "<leader>_", "<C-W>v", { desc = "Split Window Right", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

-- terminal mapping
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
-- Search and Replace normal and visual mode
------------------------------------------------------------
-- search replace
map("n", "<leader>ss",":%s/", {noremap = true, silent = false, desc = "Search and replace (local)" })
map("x", "<leader>ss",[[:s/]], {noremap = true, silent = false, desc = "Search and replace (local)" })

-- replace the current text in search register
map('n', '<leader>r',[[:%s///g<Left><Left>]], {noremap = true, silent = false, desc = "Replace search register" })

-- Visual mode pressing * or # searches for the current selection
map("x", "*",[[:<C-u>lua FrazVim.VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>]], default_opts)
map("x", "#",[[:<C-u>lua FrazVim.VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>]], default_opts)

-- Search and replace the selected text
map("x", "<leader>r",[[:<C-u>lua FrazVim.VisualSelection('replace','')<CR>]], {noremap = true, silent = false, desc = "Replace search register" })

-----------------------------------------------------------
-- Miscellaneous
-----------------------------------------------------------

-- Toogle quickfix windows
map("n", "<leader>q",":lua FrazVim.QuickFixToggle()<cr>", { noremap = true, silent = true , desc = "Toggle Quickfix" })

-- Quickly open a txt, markdown and sql buffer for scribble
map("n", "<leader><leader>x",":e " .. vim.fn.stdpath("data") .. "/scratch/buffer.txt<CR>", { noremap = true, silent = true , desc = "Edit txt scratch buffer" })
map("n", "<leader><leader>d",":e " .. vim.fn.stdpath("data") .. "/scratch/buffer.md<CR>",  { noremap = true, silent = true , desc = "Edit markdown scratch buffer" })
map("n", "<leader><leader>s",":e " .. vim.fn.stdpath("data") .. "/scratch/buffer.sql<CR>",  { noremap = true, silent = true , desc = "Edit sql scratch buffer" })


-- Map for navigating search (/?) result with tab
vim.cmd([[
        set wildcharm=<C-z>
        cnoremap <expr> <Tab> getcmdtype() =~ '[\/?]' ? "<C-g>" : "<C-z>"
        cnoremap <expr> <S-Tab> getcmdtype() =~ '[\/?]' ? "<C-t>" : "<S-Tab>"
    ]]
)

-- Labs from folke, try to map CapsLock to Control for this
vim.keymap.set("n", "<C-c>", function()
  if vim.bo.buftype ~= "terminal" then
    return "ciw"
  end
  return "<C-c>"
end, { expr = true })

-- Move on char in insert mode (not working inside wezterm)
map('i', '<C-h>', '<Left>', default_opts)
map('i', '<C-l>', '<Right>', default_opts)
map('i', '<C-j>', '<Down>', default_opts)
map('i', '<C-k>', '<Up>', default_opts)

