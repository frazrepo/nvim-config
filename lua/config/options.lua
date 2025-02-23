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
opt.cursorline = true                                       -- Enable highlighting of the current line
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
opt.gdefault                = true                          -- replace globallby by default 
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase              = true                          -- Ignore case when searching
opt.jumpoptions = "view"
opt.linebreak               = true                          -- Linebreak on 500 characters
opt.linespace               = 4                             -- Linespace
opt.list                    = false                         -- List Chars
opt.magic                   = true                          -- For regular expressions turn magic on
opt.matchpairs:append '<:>'                                 --Match pairs
opt.mouse                   = 'a'                           -- Activate mouse

opt.backup                  = false                         -- Turn backup off, since most stuff is in SVN, git et.c anyway...
opt.showmode                = false                         -- Do not show mode (displayed by lightline already)
opt.swapfile                = false
opt.writebackup             = false

opt.number                  = true                          -- Number - No Default relative number (cause slowness)
opt.scrolloff               = 1                             -- opt.1 lines to the cursor - when moving vertically using j/k
opt.shiftwidth              = 2                             -- 1 tab == 2 spaces
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shortmess:append({ W = true, I = true, c = true, C = true })

opt.showbreak               = '↪ '
opt.showmatch               = true                          -- Show matching brackets when text indicator is over them

opt.sidescrolloff = 8                                       -- Columns of context
opt.signcolumn = "yes"                                      -- Always show the signcolumn, otherwise it would shift the text each time

opt.smartcase               = true                          --Smart case for searching
opt.smartindent = true                                      -- Insert indents automatically

opt.splitbelow              = true                          -- Split mode
opt.splitright              = true
opt.splitkeep = "screen"

opt.tabstop                 = 2                             -- Tab = 2 spaces

opt.timeoutlen              = 500
opt.termguicolors           = true                          -- Enable 24-bit RGB color in the TUI

opt.updatetime              = 200                           -- Smaller updatetime for CursorHold & CursorHoldI
opt.undofile = true
opt.undolevels = 10000
opt.virtualedit             = 'block'                       -- VirtualEdit block allow selection everywhere in visual block mode
opt.wildmode = "longest:full,full"                          -- Command-line completion mode
opt.wrap = false                                            -- Disable line wrap

-- set default shell to powershell on Windows
if vim.fn.has('win32') == 1 then
    if vim.fn.executable('pwsh') == 1 then
        opt.shell = 'pwsh'
    else
        opt.shell = 'powershell'
    end
    opt.shellcmdflag = "-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';$PSStyle.OutputRendering='plaintext';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
    opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'

    -- Setting shell pipe
    opt.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'

    -- Setting shell quote options
    opt.shellquote = ""
    opt.shellxquote = ""
end

-- GUI Options and neovide settings
-- check if GUI
local is_gui = vim.g.neovide or vim.fn.has('gui_running') == 1
if is_gui then
    opt.guifont = "FiraCode Nerd Font Mono:h12"
    vim.g.neovide_cursor_animation_length = 0.02
    vim.g.neovide_cursor_trail_length = 0
    vim.g.neovide_remember_window_size = true
end

