return {
  "https://gitlab.com/yorickpeterse/nvim-dd.git",
  config = function()
    require("dd").setup {
      -- The time to wait before displaying newly produced diagnostics.
      timeout = 0,
    }
  end,
  event = "BufRead",
}
