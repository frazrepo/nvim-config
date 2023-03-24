 -- Custom plugins or experimental plugins here
return {
    -- nvim ufo
    -- see settings.lua for fold* options
    -- todo : use https://github.com/luukvbaal/statuscol.nvim but needs nvim > 0.9
    {
        'kevinhwang91/nvim-ufo',
        config = function()
            -- default mapping zR openAllFolds, zM closeAllFolds
            require('ufo').setup(
              {
                provider_selector = function(bufnr, filetype, buftype)
                  -- return {"treesitter", "indent"}
                    local function handleFallbackException(bufnr, err, providerName)
                      if type(err) == "string" and err:match "UfoFallbackException" then
                        return require("ufo").getFolds(bufnr, providerName)
                      else
                        return require("promise").reject(err)
                      end
                    end

                    return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
                      or function(bufnr)
                        return require("ufo")
                          .getFolds(bufnr, "lsp")
                          :catch(function(err) return handleFallbackException(bufnr, err, "treesitter") end)
                          :catch(function(err) return handleFallbackException(bufnr, err, "indent") end)
                      end
                end
              }
            )
        end,
        dependencies = 'kevinhwang91/promise-async'

    },
}