return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-fzy-native.nvim",
  },
  cmd = "Telescope",
  opts = function(_, opts)
    opts.extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    }
    return opts
  end,
  config = function(plugin, opts)
    -- run the core AstroNvim configuration function with the options table
    require "plugins.configs.telescope"(plugin, opts)

    -- require telescope and load extensions as necessary
    local telescope = require "telescope"
    telescope.load_extension "fzy_native"
  end,
}
