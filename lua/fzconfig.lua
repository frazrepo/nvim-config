-- Adapted from mkdir nvim plugin
-- https://github.com/jghauser/mkdir.nvim
--  create missing dir on saving a file
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

-- autogroup MkdirRun
local mygroup = vim.api.nvim_create_augroup('MkdirRun', { clear = false })
vim.api.nvim_create_autocmd({ 'BufWritePre'}, {
  pattern = '*',
  group = mygroup,
  command = 'lua run_mkdir()',
})