-----------------------------------------------------------
-- AutoCommands
-----------------------------------------------------------
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


-- autogroup EnhanceHelpView : Enhance the help view and mappings
local enhance_help = vim.api.nvim_create_augroup('EnhanceHelpView', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'help',
    group = enhance_help,
    callback = function()
        -- Help file mappings
        vim.keymap.set('n', '<cr>', '<c-]>', { buffer = true })
        vim.keymap.set('n', '<bs>', '<c-T>', { buffer = true })
        vim.keymap.set('n', 'q', ':q<CR>', { buffer = true })
        
        -- Set options
        vim.opt_local.number = false
        
        -- Maximize help window
        vim.cmd('wincmd _')
    end,
})
 
 -- autogroup AutoSaveScratch : Autosave scratch buffers
local autosave_scratch = vim.api.nvim_create_augroup('AutoSaveScratch', { clear = true })
vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
    pattern = 'buffer.*',
    group = autosave_scratch,
    command = 'update',
    nested = true,
})
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
    pattern = 'buffer.*',
    group = autosave_scratch,
    command = 'checktime',
})


-----------------------------------------------------------
-- Commands
-----------------------------------------------------------

-- VisualBlock: Workaround to start visual block mode on terminal if C-v or C-q is not working
vim.api.nvim_create_user_command('VisualBlock', function()
    vim.cmd('normal! \22') -- \22 is ctrl-v
end, {})

-- W: sudo saves the file (useful for handling the permission-denied error on Linux)
vim.api.nvim_create_user_command('W', function()
    vim.fn.system('sudo tee ' .. vim.fn.expand('%') .. ' > /dev/null', vim.fn.getline(1, '$'))
end, {})

-- SortByWidth: Sort lines by width
vim.api.nvim_create_user_command('SortByWidth', function(opts)
    local line1 = opts.line1
    local line2 = opts.line2
    FrazUtil.SortLinesByWidth(line1, line2)
end, { range = '%' })

-- WipeReg: Clean all registers
vim.api.nvim_create_user_command('WipeReg', function()
    for i = 34, 122 do
        vim.fn.setreg(string.char(i), {})
    end
end, {})

-- RemoveTrailingSpaces: Remove all trailing spaces
vim.api.nvim_create_user_command('RemoveTrailingSpaces', function()
    FrazUtil.CleanExtraSpaces()
end, {})
