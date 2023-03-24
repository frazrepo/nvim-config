return {
  -----------------------------------------------------------
  -- Motions
  -----------------------------------------------------------

  -- leap like next version of lightspeed
  {
      'ggandor/leap.nvim',
      config = function()
          require('leap').add_default_mappings()
      end,
  },

  -- Flit : easily jump to any location and enhanced f/t motions for Leap
  -- Can jump on the next occurence with <CR>
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