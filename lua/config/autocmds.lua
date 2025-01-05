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


local bo = vim.bo
local getCursor = vim.api.nvim_win_get_cursor
local setCursor = vim.api.nvim_win_set_cursor

-- local M = {}
local keymap = vim.keymap.set
-- https://github.com/chrisgrieser/nvim-various-textobjs/blob/main/lua/various-textobjs.lua


---@return boolean
local function isVisualLineMode()
	local modeWithV = fn.mode():find("V")
	return modeWithV ~= nil
end

---runs :normal natively with bang
---@param cmdStr any
local function normal(cmdStr)
	local is08orHigher = vim.version().major > 0 or vim.version().minor > 7
	if is08orHigher then
		vim.cmd.normal { cmdStr, bang = true }
	else
		vim.cmd("normal! " .. cmdStr)
	end
end

---sets the selection for the textobj (linewise)
---@param startline integer
---@param endline integer
-- local function setLinewiseSelection(startline, endline)
function setLinewiseSelection(startline, endline)
	setCursor(0, { startline, 0 })
	if not isVisualLineMode() then normal("V") end
	normal("o")
	setCursor(0, { endline, 0 })
end


-- Experimental mapping ygG to select entire buffer
-- meme résultat que yie, on ne garder pas la position du curseur

keymap({ "o", "x" }, "gG", function()  setLinewiseSelection(1, fn.line("$")) end, { desc = "entireBuffer" .. " textobj" })
