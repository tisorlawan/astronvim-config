return {
  "simrat39/rust-tools.nvim",
  ft = { "rust" },
  opts = function(_, opts)
    if not opts.tools then opts.tools = {} end
    opts.tools = {
      inlay_hints = {
        auto = false,
      },
    }
  end,
}
