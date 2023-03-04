local bo = vim.bo
local fn = vim.fn
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
keymap({ "o", "x" }, "gG", function()  setLinewiseSelection(1, fn.line("$")) end, { desc = "entireBuffer" .. " textobj" })
