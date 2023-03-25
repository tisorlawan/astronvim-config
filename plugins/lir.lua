return {
  "tamago324/lir.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function() require("user.configs.lir").setup() end,
}
