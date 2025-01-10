
-- Import all extras plugins
return {
    { import = 'plugins.extras.motion'},
    { import = 'plugins.extras.util'},
    { import = 'plugins.extras.ui'},

    -- Validated plugins in extras should be move to specific folder
    { import = 'plugins.extras.lab'},
}
