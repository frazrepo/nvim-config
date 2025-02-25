
-- See if Snack picker symbols is enough
return {
      {
        'Bekaboo/dropbar.nvim',
        event = 'VeryLazy',
        -- optional, but required for fuzzy finder support
        -- dependencies = {
        --   'nvim-telescope/telescope-fzf-native.nvim',
        --   build = 'make'
        -- },
        config = function()
          local dropbar_api = require('dropbar.api')
          -- Disable this mappings as it conflicts with livegrep for telescope
          -- vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
          vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
          vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
        end
      }
}
