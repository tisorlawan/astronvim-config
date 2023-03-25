return {
  "mhinz/vim-grepper",
  cmd = "Grepper",
  event = "BufRead",
  config = function()
    require("user.configs.grepper").setup()
  end,
}
