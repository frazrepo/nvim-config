if not FrazVim.extras.lang.powershell then 
    return {} 
end
return {
    {
        "Willem-J-an/nvim-dap-powershell",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
            {
                "m00qek/baleia.nvim",
                lazy = true,
                tag = "v1.4.0",
            },
        },
        config = function()
            require("dap-powershell").setup()
        end,
    }
}