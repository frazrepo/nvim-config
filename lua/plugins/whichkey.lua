-----------------------------------------------------------
-- Whichkey configuration file
-- Plugin: whichkey
-- https://github.com/folke/which-key.nvim
-----------------------------------------------------------

local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    name = "Leader",
    ["/"] = { "Global Search" },
    ["r"] = { "Replace Search Register" },
    ["x"] = { "Edit txt buffer" },
    ["d"] = { "Edit markdown buffer" },
    ["s"] = { "Edit sql buffer" },
    ["e"] = { "Edit in current buffer path" },
    ["!"] = { "Delete buffer" },
    ["w"] = { "Save buffer" },
    ["m"] = { "Remove special char M" },
    [","] = { "Find buffer" },
    [";"] = { "Find lines in buffer" },
    ["u"] = { 'Open Recent File' },
    c = {
        ["d"] = { "Change to current buffer directory" },
    },
    f = {
        ["r"] = { "Find Replace Visually" },
    },
    t = {
        ["e"] = { "Tab Edit in current buffer path" },
    },
  },
  g = {
    name = 'Buffer',
    ["="] = { 'Format buffer' },
    ["a"] = { 'Easy Align Operator' },
    ["b"] = { 'Block Comment' },
    ["c"] = { 'Comment' },
    ["l"] = { 'Go align right' },
    ["L"] = { 'Go align left' },
    ["q"] = { 'Format' },
    ["Q"] = { 'Format buffer' },
    ["s"] = { 'Sort operator' },
    ["v"] = { 'Reselect last visual selection' },
    ["V"] = { 'Reselect last pasted text' },
  },
})
