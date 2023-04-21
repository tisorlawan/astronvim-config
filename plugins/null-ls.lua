local nls = require "null-ls"

return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, opts)
    opts.debug = true

    local sources = {
      nls.builtins.diagnostics.ruff.with {
        method = nls.methods.DIAGNOSTICS_ON_SAVE,
      },
    }

    if type(opts.sources) == "table" then
      vim.list_extend(opts.sources, sources)
    else
      opts.sources = sources
    end
  end,
}
