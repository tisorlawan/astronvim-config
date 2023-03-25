return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  config = function() require("user.configs.lualine").setup() end,
  dependencies = { "nvim-web-devicons" },
}
