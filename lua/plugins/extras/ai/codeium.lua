
return {
    -- Usage : use :Codeium auth and follow instructions
    -- Tab for completion - virtual text
    {
      "Exafunction/codeium.nvim",
      cond = FrazUtil.extras.aiengine == "codeium",
      cmd = "Codeium",
      event = "InsertEnter",
      build = ":Codeium Auth",
      opts = {
        enable_cmp_source = false,
        virtual_text = {
          enabled = true,
          key_bindings = {
            -- accept = false, -- handled by nvim-cmp / blink.cmp
            -- next = "<M-]>",
            -- prev = "<M-[>",
          },
        },
      },
    }
}
