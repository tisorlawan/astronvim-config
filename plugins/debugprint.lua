return {
  "andrewferrier/debugprint.nvim",
  event = "BufRead",
  config = function()
    require("debugprint").setup()
  end,
}
