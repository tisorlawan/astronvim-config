return {
  {
    "TimUntersberger/neogit",
    cmd = { "Neogit" },
    config = function() require("user.configs.neogit").setup() end,
    dependencies = "nvim-lua/plenary.nvim",
  },
  {
    "sindrets/diffview.nvim",
    module = { "diffview" },
    config = function() require("user.configs.diffview").setup() end,
  },
}
