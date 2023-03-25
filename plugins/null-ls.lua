local with_diagnostics_code = function(builtin)
  return builtin.with {
    diagnostics_format = "#{m} [#{c}]",
  }
end

local with_root_file = function(builtin, file)
  return builtin.with {
    condition = function(utils)
      return utils.root_has_file(file)
    end,
  }
end

return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"
    local b = null_ls.builtins

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      -- null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.prettier,
      b.formatting.prettierd,
      b.formatting.shfmt,
      b.formatting.fixjson,
      b.formatting.black.with { extra_args = { "--fast" } },
      with_root_file(b.formatting.stylua, "stylua.toml"),

      -- diagnostics
      b.diagnostics.write_good,
      -- b.diagnostics.markdownlint,
      b.diagnostics.ruff,
      b.diagnostics.tsc,
      with_root_file(b.diagnostics.selene, "selene.toml"),
      with_diagnostics_code(b.diagnostics.shellcheck),
      b.diagnostics.eslint_d.with({
        diagnostics_format = '[eslint] #{m}\n(#{c})'
      }),
    }
    return config -- return final config table
  end,
}
