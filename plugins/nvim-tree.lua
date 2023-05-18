return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle" },
  config = function()
    require("nvim-tree").setup {
      sort_by = "case_sensitive",
      view = {
        width = 40,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
      hijack_netrw = false,
    }
  end,
}
