-----------------------------------------------------------
-- Settings
-----------------------------------------------------------

--Neovim aliases
--
local opt = vim.opt
local g   = vim.g
local cmd = vim.cmd     				-- execute Vim commands
local exec = vim.api.nvim_exec 	        -- execute Vimscript

--Settings

opt.backspace               = 'eol,start,indent'            -- Configure backspace so it acts as it should act
opt.clipboard               = 'unnamed,unnamedplus'         -- Default to system clipboard
opt.complete                = '.,w,b,u'                     -- Complete option
opt.cpoptions:append '>'                                    -- Put a line break before appended text (appending to register)
opt.encoding                = 'utf-8'                       -- Dealing with special chars
opt.expandtab               = true                          -- Use spaces instead of tabs

opt.foldlevelstart          = 99 
opt.foldmethod              = 'indent'                      -- Default Foldmethod indent
opt.formatoptions           = 'qnj1'                        -- q  - comment formatting; n - numbered lists; j - remove comment when joining lines; 1 - don't break after one-letter word
opt.gdefault                = true
opt.hidden                  = true                          -- Set hidden to allow switching to other buffer if it is modifie
opt.ignorecase              = true                          -- Ignore case when searching
opt.lazyredraw              = true                          -- Don't redraw while executing macros (good performance config)
opt.linebreak               = true                          -- Linebreak on 500 characters
opt.linespace               = 4                             -- Linespace
opt.magic                   = true                          -- For regular expressions turn magic on
opt.matchpairs:append '<:>'                                 --Match pairs
opt.mouse                   = 'a'                           -- Activate mouse

opt.backup                  = false                         -- Turn backup off, since most stuff is in SVN, git et.c anyway...
opt.list                    = false                         -- List Chars
opt.showmode                = false                         -- Do not show mode (displayed by lightline already)
opt.swapfile                = false
opt.writebackup             = false

opt.number                  = true                          -- Number - No Default relative number (cause slowness)
opt.scrolloff               = 1                             -- opt.1 lines to the cursor - when moving vertically using j/k
opt.shiftwidth              = 4                             -- 1 tab == 4 spaces

opt.shortmess:append 'c'                                    -- don't give |ins-completion-menu| messages.
opt.shortmess               = 'atI'                         -- Disable startup message

opt.showbreak               = '↪ ' 
opt.showmatch               = true                          -- Show matching brackets when text indicator is over them

opt.smartcase               = true                          --Smart case for searching

opt.splitbelow              = true                          -- Split mode
opt.splitright              = true


opt.synmaxcol               = 200                           -- And optimize performance for longlines
opt.tabstop                 = 4

opt.timeout                 = true
opt.timeoutlen              = 500 
opt.ttimeoutlen             = 50
opt.textwidth               = 500

opt.updatetime              = 300                           -- Smaller updatetime for CursorHold & CursorHoldI
opt.virtualedit             = 'block'                       -- VirtualEdit block allow selection everywhere in visual block mode
opt.visualbell              = true                          -- t_vb =-- No sound on errors
opt.whichwrap:append        '<,>,h,l'

opt.cmdheight               = 2                             --Fix : Press Enter or Type Command to continue error in nvim 
-- opt.signcolumn              =true                        -- always show signcolumns

opt.inccommand              = "nosplit"                     -- search/replace preview

-- disable some builtin vim plugins
local disabled_built_ins = {
   "2html_plugin",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "matchit",
   "tar",
   "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   "zip",
   "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
   g["loaded_" .. plugin] = 1
end

-- autocommand
cmd(
   [[
         au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}
]])


-- Functions
exec([[
        function! CleanExtraSpaces()
            let save_cursor = getpos(".")
            let old_query = getreg('/')
            silent! %s/\s\+$//e
            call setpos('.', save_cursor)
            call setreg('/', old_query)
        endfun

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

        function! QuickFixToggle()
            if empty(filter(getwininfo(), 'v:val.quickfix'))
                copen
            else
                cclose
            endif
        endfunction

        function! ExecuteMacroOverVisualRange()
          echo "@".getcmdline()
          execute ":'<,'>normal @".nr2char(getchar())
        endfunction

        function! SortLinesByWidth() range
            silent! execute a:firstline . "," . a:lastline . 's/^\(.*\)$/\=strdisplaywidth( submatch(0) ) . " " . submatch(0)/'
            silent! execute a:firstline . "," . a:lastline . 'sort n'
            silent! execute a:firstline . "," . a:lastline . 's/^\d\+\s//'
        endfunction

    ]], false)

-- Commands

--  VisualBlock :  Workaround to start visual block mode on terminal if C-v or C-q is not working
cmd(
    [[
    command! VisualBlock execute "normal! \<C-v>"
    ]]
)

--  W : sudo saves the file (useful for handling the permission-denied error on Linux)
cmd(
    [[
    command! W w !sudo tee % > /dev/null
    ]]
)

-- SortByWidth : Sort lines by width
cmd(
    [[
    command! -range=%  SortByWidth <line1>,<line2>call SortLinesByWidth()
    ]]
)

-- WipeReg : Clean all registers
cmd(
    [[
    command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor 
    ]]
)

-- RemoveTrailingSpaces : Remove all training spaces
cmd(
    [[
    command! RemoveTrailingSpaces call CleanExtraSpaces()
    ]]
)

-- AutoCommands
exec([[
    augroup AutoCommandsGroup
        autocmd!

        " Clean extra spaces on txt files 
        autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()

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

-- AutoCommands for powershell bindings
exec([[
        augroup psbindings
            autocmd! psbindings
            autocmd Filetype ps1 nnoremap <buffer> <F8> :CocCommand powershell.evaluateLine<CR>
            autocmd Filetype ps1 vnoremap <buffer> <F8> :CocCommand powershell.evaluateSelection<CR>
            autocmd Filetype ps1 nnoremap <buffer> <F5> :CocCommand powershell.execute<CR>
        augroup end
 ]], false)


-- TODO : to test , default shell (bug here)
-- local function default_shell() 
-- 	if vim.fn.has('win32') == 1  then
-- 	    opt.shell = "powershell.exe"
--     end
-- -- end
-- exec(
--     [[
--         if has('win32')
--             set shell=powershell.exe
--         endif
--     ]]
-- ,false)
