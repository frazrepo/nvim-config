return {
    {
        -- When not working doing a :Copilot log may help
        -- Error : SEFL_SIGNED_CERT_IN_CHAIN
        -- Solution : Trust the certificate in nodejs store using the env variable NODE_EXTRA_CA_CERTS
        -- Usage :
        -- :Copilot log
        -- <Tab> to complete suggestion
        "github/copilot.vim",
        -- enabled = false
        cond = FrazVim.extras.ai.engine == "copilot",
        cmd = "Copilot",
        event = "InsertEnter",
    }
}
