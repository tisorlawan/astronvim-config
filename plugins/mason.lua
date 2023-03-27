local utils = require "astrocommunity.utils"

return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      if not opts.ensure_installed then opts.ensure_installed = {} end
      utils.list_insert_unique(opts.ensure_installed, { "ruff_lsp", "eslint" })
    end,
  },
}
