
-- Import all extras plugins
return {
    { import = 'plugins.extras.util'},
    { import = 'plugins.extras.ui'},
    { import = 'plugins.extras.ai'},
    { import = 'plugins.extras.coding'},

    -- Validated plugins in extras should be move to specific folder
    { import = 'plugins.extras.lab'},
}
