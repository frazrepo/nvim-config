return {
  -----------------------------------------------------------
  -- Motions
  -----------------------------------------------------------

  -- leap like next version of lightspeed
  -- s{char1}{char2} then jump to next /previous with Enter/Tab
  -- operator mode :  x/X{char1}{char2} : eg dxca
  -- visual mode : vx{char1}{char2}
  {
      'ggandor/leap.nvim',
      config = function()
          require('leap').add_default_mappings()
      end,
  },

  -- Flit : easily jump to any location and enhanced f/t motions for Leap
  -- Can jump/previous on the next occurence with <CR>/<Tab>
  {
      "ggandor/flit.nvim",
      dependencies ={ "ggandor/leap.nvim"},
      event = "VeryLazy",
      config = function(_, opts)
         require('flit').setup {
            keys = { f = 'f', F = 'F', t = 't', T = 'T' },
            -- A string like "nv", "nvo", "o", etc.
            labeled_modes = "v",
            multiline = true,
            -- Like `leap`s similar argument (call-specific overrides).
            -- E.g.: opts = { equivalence_classes = {} }
            opts = {}
          }
      end,
  }
}
