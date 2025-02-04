-----------------------------------------------------------
-- AutoCommands
-----------------------------------------------------------

local function augroup(name)
  return vim.api.nvim_create_augroup("frazvim_" .. name, { clear = true })
end


-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank { higroup = "IncSearch", timeout = 150 }
    end,
})

-- Create missing dir on saving a file
-- Adapted from mkdir nvim plugin : https://github.com/jghauser/mkdir.nvim
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

vim.api.nvim_create_autocmd({ 'BufWritePre'}, {
  pattern = '*',
  group = augroup("mkdir_run"),
  command = 'lua run_mkdir()',
})


-- Enhance the help view and mappings
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'help',
    group = augroup("enhance_help"),
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
 
 -- Autosave scratch buffers
local autosave_scratch = augroup("autosave_scratch")
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

-- Set root dir
-- Array of file names indicating root directory. Modify to your liking.
local root_names = { '.git', 'Makefile' }

-- Cache to use for speed up (at cost of possibly outdated results)
local root_cache = {}

local set_root = function()
  -- Get directory path to start search from
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' then return end
  path = vim.fs.dirname(path)

  -- Try cache and resort to searching upward for root directory
  local root = root_cache[path]
  if root == nil then
    local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
    if root_file == nil then return end
    root = vim.fs.dirname(root_file)
    root_cache[path] = root
  end

  -- Set current directory
  vim.fn.chdir(root)
end

vim.api.nvim_create_autocmd('BufEnter', { group = augroup("auto_root"), callback = set_root })

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "checkhealth",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    -- "help",
    "lspinfo",
    "notify",
    -- "qf",
    "startuptime",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
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
    FrazVim.SortLinesByWidth(line1, line2)
end, { range = '%' })

-- WipeReg: Clean all registers
vim.api.nvim_create_user_command('WipeReg', function()
    for i = 34, 122 do
        vim.fn.setreg(string.char(i), {})
    end
end, {})

-- RemoveTrailingSpaces: Remove all trailing spaces
vim.api.nvim_create_user_command('RemoveTrailingSpaces', function()
    FrazVim.CleanExtraSpaces()
end, {})
-- Create  a mapping to call the commande RemoveTrailingSpaces
vim.keymap.set('n', '<leader>m<space>', ':RemoveTrailingSpaces<CR>', { desc = 'Remove trailing spaces' })
