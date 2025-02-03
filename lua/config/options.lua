-----------------------------------------------------------
-- Settings
-----------------------------------------------------------

--Neovim aliases
--
local opt = vim.opt

--Settings

opt.backspace               = 'eol,start,indent'            -- Configure backspace so it acts as it should act
opt.clipboard               = 'unnamed,unnamedplus'         -- Default to system clipboard
opt.complete                = '.,w,b,u'                     -- Complete option
opt.cpoptions:append '>'                                    -- Put a line break before appended text (appending to register)
opt.conceallevel = 2                                        -- Hide * markup for bold and italic, but not markers with substitutions

opt.encoding                = 'utf-8'                       -- Dealing with special chars
opt.expandtab               = true                          -- Use spaces instead of tabs

opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.formatoptions           = 'qnj1'                        -- q  - comment formatting; n - numbered lists; j - remove comment when joining lines; 1 - don't break after one-letter word
opt.gdefault                = true
opt.hidden                  = true                          -- Set hidden to allow switching to other buffer if it is modifie
opt.ignorecase              = true                          -- Ignore case when searching
-- Disable for noice warning
-- opt.lazyredraw              = true                          -- Don't redraw while executing macros (good performance config)
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
opt.sessionoptions          = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

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
opt.termguicolors           = true

opt.updatetime              = 300                           -- Smaller updatetime for CursorHold & CursorHoldI
opt.virtualedit             = 'block'                       -- VirtualEdit block allow selection everywhere in visual block mode
opt.visualbell              = true                          -- t_vb =-- No sound on errors
opt.whichwrap:append        '<,>,h,l'
opt.wrap = false                                            -- Disable line wrap

opt.cmdheight               = 2                             --Fix : Press Enter or Type Command to continue error in nvim
-- opt.signcolumn              =true                        -- always show signcolumns

opt.inccommand              = "nosplit"                     -- search/replace preview

-- set default shell to powershell on Windows
if vim.fn.has('win32') == 1 then
    if vim.fn.executable('pwsh') == 1 then
        opt.shell = 'pwsh'
    else
        opt.shell = 'powershell'
    end
    opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
    opt.shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
    opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    opt.shellquote = ''
    opt.shellxquote = ''
end

-- GUI Options and neovide settings
opt.guifont = "FiraCode Nerd Font Mono:h12"
vim.g.neovide_cursor_animation_length = 0.02
vim.g.neovide_cursor_trail_length = 0
vim.g.neovide_remember_window_size = true

