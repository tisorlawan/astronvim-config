return {
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      local handle = io.popen "which python"
      local python_path = handle:read "*l"
      handle:close()
      require("dap-python").setup(python_path)
    end,
    ft = "python",
  },
}
