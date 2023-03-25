return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = "all",
      indent = {
        enable = true,
        disable = { "python" }
      },
      yati = { enable = true },
    },
  },
  {
    "yioneko/nvim-yati",
    ft = "python",
  },
}
