return {
  {
    "aktersnurra/no-clown-fiesta.nvim",
    config = function()
      require("no-clown-fiesta").setup {
        transparent = false, -- Enable this to disable the bg color
        styles = {
          -- You can set any of the style values specified for `:h nvim_set_hl`
          comments = {},
          keywords = {},
          functions = {},
          variables = {},
          type = { bold = true },
          lsp = { underline = true },
        },
      }
    end,
  },
  {
    "savq/melange-nvim",
  },
  {
    "luisiacc/gruvbox-baby",
  },
  {
    "AlexvZyl/nordic.nvim",
  },
  {
    "olivercederborg/poimandres.nvim",
    config = function()
      require("poimandres").setup {
        -- leave this setup function empty for default config
        -- or refer to the configuration section
        -- for configuration options
      }
    end,
  },
}
