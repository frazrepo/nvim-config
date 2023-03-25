-----------------------------------------------------------
-- Vim-grepper configuration file
-- Plugin: vim-grepper
-- https://github.com/mhinz/vim-grepper
-----------------------------------------------------------

local wk = require('which-key')

vim.g.grepper = {
  tools = {'rg', 'git'},
  rg = {
    grepprg = 'rg -H --no-heading --vimgrep --hidden'
  },
}

wk.register(
  {
    g = { '<Cmd>Grepper -buffer<Cr>', 'Grepper in current buffer' },
    ["/"] = { '<Cmd>Grepper<Cr>', 'Grepper' },
    G = { '<Cmd>Grepper -buffers<Cr>', 'Grepper in all Buffers' },
    ['*'] = { '<Cmd>Grepper -cword -noprompt<Cr>', 'Grepper Word Under Cursor' },
  },
  {
    prefix = '<Leader>',
  }
)


wk.register(
  {
    gx = { '<Plug>(GrepperOperator)', 'Grepper Operator' },
  },
  {
    mode = 'n',
  }
)

wk.register(
  {
    gx = { '<Plug>(GrepperOperator)', 'Grepper Operator' },
  },
  {
    mode = 'x',
  }
)


-- " Project wide find and replace. It's similar to <leader>r but applies to all matches
-- " across all files.

  -- \ :let @s='\<'.expand('<cword>').'\>'<CR>
vim.cmd(
  [[
  nnoremap <Leader>R
  \ :let @s=expand('<cword>')<CR>
  \ :Grepper -cword -noprompt<CR>
  \ :cfdo %s/<C-r>s//g \| update
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
]]
)


-- " Visual Selection Variant
vim.cmd(
  [[
    xmap <Leader>R
   \ "sy
   \ :Grepper -cword -noprompt<CR>
    \ :cfdo %s/<C-r>s//g \| update
     \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
 ]]
)

-- Custom commands
-- https://github.com/mhinz/vim-grepper/wiki/example-configurations-and-mappings
vim.cmd([[
  command! Todo :Grepper -tool git -query '\(TODO\|FIXME\)'
]])