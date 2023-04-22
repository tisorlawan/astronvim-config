return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-fzy-native.nvim",
    "debugloop/telescope-undo.nvim",
  },
  cmd = "Telescope",
  opts = function(_, opts)
    opts.extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
      undo = {
        mappings = {
          i = {
            -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
            -- you want to replicate these defaults and use the following actions. This means
            -- installing as a dependency of telescope in it's `requirements` and loading this
            -- extension from there instead of having the separate plugin definition as outlined
            -- above.
            ["<cr>"] = require("telescope-undo.actions").yank_additions,
            ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
            ["<C-cr>"] = require("telescope-undo.actions").restore,
          },
        },
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
    telescope.load_extension "undo"
  end,
}
