
-- autogroup TextYankPost : highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank { higroup = "IncSearch", timeout = 150 }
    end,
})


-- autogroup MkdirRun
-- Adapted from mkdir nvim plugin : https://github.com/jghauser/mkdir.nvim
-- Create missing dir on saving a file
local fn = vim.fn
function run_mkdir()
  local dir = fn.expand('<afile>:p:h')

  -- This handles URLs using netrw. See ':help netrw-transparent' for details.
  if dir:find('%l+://') == 1 then
    return
  end

  if fn.isdirectory(dir) == 0 then
    fn.mkdir(dir, 'p')
  end
end

local mygroup = vim.api.nvim_create_augroup('MkdirRun', { clear = false })
vim.api.nvim_create_autocmd({ 'BufWritePre'}, {
  pattern = '*',
  group = mygroup,
  command = 'lua run_mkdir()',
})

-- Helper Functions
vim.api.nvim_exec([[
        function! CmdLine(str)
            call feedkeys(":" . a:str)
        endfunction

        function! VisualSelection(direction, extra_filter) range
            let l:saved_reg = @"
            execute "normal! vgvy"

            let l:pattern = escape(@", "\\/.*'$^~[]")
            let l:pattern = substitute(l:pattern, "\n$", "", "")

            if a:direction == 'gv'
                call CmdLine("Ack '" . l:pattern . "' " )
            elseif a:direction == 'replace'
                call CmdLine("%s" . '/'. l:pattern . '/')
            endif

            let @/ = l:pattern
            let @" = l:saved_reg
        endfunction

        function! SortLinesByWidth() range
            silent! execute a:firstline . "," . a:lastline . 's/^\(.*\)$/\=strdisplaywidth( submatch(0) ) . " " . submatch(0)/'
            silent! execute a:firstline . "," . a:lastline . 'sort n'
            silent! execute a:firstline . "," . a:lastline . 's/^\d\+\s//'
        endfunction

    ]], false)

-- Commands

--  VisualBlock :  Workaround to start visual block mode on terminal if C-v or C-q is not working
vim.cmd(
    [[
    command! VisualBlock execute "normal! \<C-v>"
    ]]
)

--  W : sudo saves the file (useful for handling the permission-denied error on Linux)
vim.cmd(
    [[
    command! W w !sudo tee % > /dev/null
    ]]
)

-- SortByWidth : Sort lines by width
vim.cmd(
    [[
    command! -range=%  SortByWidth <line1>,<line2>call SprtLinesByWidth()
    ]]
)

-- WipeReg : Clean all registers
vim.cmd(
    [[
    command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
    ]]
)

-- RemoveTrailingSpaces : Remove all trailing spaces
vim.cmd(
    [[
    command! RemoveTrailingSpaces lua FzUtils.CleanExtraSpaces()
    ]]
)

-- AutoCommands
vim.api.nvim_exec([[
    augroup AutoCommandsGroup
        autocmd!

        " Help File speedups, <enter> to follow tag, delete (backspace) for back
        autocmd filetype help nnoremap <buffer><cr> <c-]>
        autocmd filetype help nnoremap <buffer><bs> <c-T>
        autocmd filetype help nnoremap <buffer>q :q<CR>
        autocmd filetype help set nonumber
        autocmd filetype help wincmd _ " Maximize the help on open

        " AutoSave Scratch buffer
        autocmd InsertLeave,TextChanged buffer.* nested silent! update
        autocmd FocusGained,BufEnter,CursorHold buffer.* silent! checktime

    augroup END
 ]], false)
