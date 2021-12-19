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
    -- g = { '<Cmd>Grepper<Cr>', 'Grepper' },
    ["/"] = { '<Cmd>Grepper<Cr>', 'Grepper' },
    G = { '<Cmd>Grepper -buffers<Cr>', 'Grepper Buffers' },
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



-- TODO
-- let g:grepper={}
-- let g:grepper.tools=["rg", "git"]
--
-- nmap     <leader>/ :GrepperRg<Space>
-- vmap     <leader>/ "sy:GrepperRg -F '<C-r>s'<Space>
-- vmap     <leader>gr <plug>(GrepperOperator)
--
-- nnoremap <Leader>* :Grepper -cword -noprompt<CR>

-- " Project wide find and replace. It's similar to <leader>r but applies to all matches
-- " across all files.
-- nnoremap <Leader>R
--   \ :let @s='\<'.expand('<cword>').'\>'<CR>
--   \ :Grepper -cword -noprompt<CR>
--   \ :cfdo %s/<C-r>s//g \| update
--   \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
--
-- " Visual Selection Variant
-- xmap <Leader>R
--     \ "sy
--     \ gv<Leader>gr
--     \ :cfdo %s/<C-r>s//g \| update
--      \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
--
