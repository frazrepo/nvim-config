-- VSCode extension

local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true  }
local cmd = vim.cmd
local opt = vim.opt

--################################################
-- settings and options
--################################################
opt.clipboard               = 'unnamed,unnamedplus'         -- Default to system clipboard

--################################################
--#region keymap
--################################################
vim.g.mapleader = " "

-- https://vi.stackexchange.com/a/31887
local nv_keymap = function(lhs, rhs)
  vim.api.nvim_set_keymap('n', lhs, rhs, { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', lhs, rhs, { noremap = true, silent = true })
end

local nx_keymap = function(lhs, rhs)
  vim.api.nvim_set_keymap('n', lhs, rhs, { silent = true })
  vim.api.nvim_set_keymap('v', lhs, rhs, { silent = true })
end

-- Clear search highlighting
map('', '<space><space>', ':nohl<CR>', {silent = true})

-- Fast saving
map('n', '<leader>w', ':w!<CR>', {noremap =false, silent = true})

-- H and L Begin/End on homerow
map('n', 'H', '^'  , {noremap =false, silent = true})
map('n', 'L', 'g_'  , {noremap =false, silent = true})

-- Repeat . command in visual mode
map('v', '.', ':normal.<CR>', {noremap = true})

-- Keep selection in select mode after shifting
-- Indenting not working when the line starts with ##
map('v', '>', '>gv', default_opts)
map('v', '<', '<gv', default_opts)

-- " Reselect last insertext
map('n', 'gV','`[v`]', default_opts)

-- " Quick yanking to the end of the line
map('n', 'Y', 'y$', default_opts)

-- " Quick macro recording and replaying ,qq for recording, and Q for replaying
map('n', 'Q', '@q', default_opts)
map('x', 'Q', ':normal @q<CR>', default_opts)

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

-- " Indent/Format All documents using = or gq
map('n', 'g=','mmgg=G`m', default_opts)
map('n', 'gQ','mmgggqG`m', default_opts)

-- " Change word under cursor and dot repeat, really useful to edit quickly
map('n', 'c*' , '*Ncgn' , default_opts)
map('n', 'c#' , '#NcgN' , default_opts)
map('n', 'cg*', 'g*Ncgn', default_opts)
map('n', 'cg#', 'g#Ncgn', default_opts)


-- Buffer(entire) text-object
-----------------------------
-- Line text-object
-------------------
-- il al
map('x', 'il','g_o0', default_opts)
map('o', 'il',':<C-u>normal vil<CR>', default_opts)
map('x', 'al','$o0', default_opts)
map('o', 'al',':<C-u>normal val<CR>', default_opts)

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


--################################################
-- Todo : refactor to lua
--################################################
vim.cmd ([[

        " Highlight yank
        augroup highlight_yank
            autocmd!
            autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup="IncSearch", timeout=300 }
        augroup END

        " Functions
        function! s:split(...) abort
            let direction = a:1
            let file = a:2
            call VSCodeCall(direction == 'h' ? 'workbench.action.splitEditorDown' : 'workbench.action.splitEditorRight')
            if file != ''
                call VSCodeExtensionNotify('open-file', expand(file), 'all')
            endif
        endfunction

        function! s:splitNew(...)
            let file = a:2
            call s:split(a:1, file == '' ? '__vscode_new__' : file)
        endfunction

        function! s:closeOtherEditors()
            call VSCodeNotify('workbench.action.closeEditorsInOtherGroups')
            call VSCodeNotify('workbench.action.closeOtherEditors')
        endfunction

        function! s:manageEditorSize(...)
            let count = a:1
            let to = a:2
            for i in range(1, count ? count : 1)
                call VSCodeNotify(to == 'increase' ? 'workbench.action.increaseViewSize' : 'workbench.action.decreaseViewSize')
            endfor
        endfunction

        function! s:openVSCodeCommandsInVisualMode()
            normal! gv
            let visualmode = visualmode()
            if visualmode == "V"
                let startLine = line("v")
                let endLine = line(".")
                call VSCodeNotifyRange("workbench.action.showCommands", startLine, endLine, 1)
            else
                let startPos = getpos("v")
                let endPos = getpos(".")
                call VSCodeNotifyRangePos("workbench.action.showCommands", startPos[1], endPos[1], startPos[2], endPos[2], 1)
            endif
        endfunction

        function! s:openWhichKeyInVisualMode()
            normal! gv
            let visualmode = visualmode()
            if visualmode == "V"
                let startLine = line("v")
                let endLine = line(".")
                call VSCodeNotifyRange("whichkey.show", startLine, endLine, 1)
            else
                let startPos = getpos("v")
                let endPos = getpos(".")
                call VSCodeNotifyRangePos("whichkey.show", startPos[1], endPos[1], startPos[2], endPos[2], 1)
            endif
        endfunction

        " Other mappings

        command! -complete=file -nargs=? Split call <SID>split('h', <q-args>)
        command! -complete=file -nargs=? Vsplit call <SID>split('v', <q-args>)
        command! -complete=file -nargs=? New call <SID>split('h', '__vscode_new__')
        command! -complete=file -nargs=? Vnew call <SID>split('v', '__vscode_new__')
        command! -bang Only if <q-bang> == '!' | call <SID>closeOtherEditors() | else | call VSCodeNotify('workbench.action.joinAllGroups') | endif

        " Buffers
        nnoremap <leader>bn :Vnew<cr>


        " Better Navigation
        nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
        xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
        nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
        xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
        nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
        xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
        nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
        xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>

        " whichkey , need whichkey extension in vscode
        nnoremap <silent> , :call VSCodeNotify('whichkey.show')<CR>
        xnoremap <silent> , :<C-u>call <SID>openWhichKeyInVisualMode()<CR>

        nnoremap <silent> <C-w>_ :<C-u>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>

        "Commentary
        xmap gc  <Plug>VSCodeCommentary
        nmap gc  <Plug>VSCodeCommentary
        omap gc  <Plug>VSCodeCommentary
        nmap gcc <Plug>VSCodeCommentaryLine
    ]])