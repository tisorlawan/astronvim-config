return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  { import = "astrocommunity.colorscheme.kanagawa",              enabled = true },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.motion.mini-surround" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  -- { import = "astrocommunity.utility.noice-nvim" },

  {
    "kanagawa.nvim",
    opts = {
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      variablebuiltinStyle = { italic = true },
      specialReturn = true,    -- special highlight for the return keyword
      specialException = true, -- special highlight for exception handling keywords
      transparent = false,     -- do not set background color
      dimInactive = true,      -- dim inactive window `:h hl-NormalNC`
      globalStatus = false,    -- adjust window separators highlight for laststatus=3
      terminalColors = true,   -- define vim.g.terminal_color_{0,17}
      colors = {},
      theme = "default",       -- Load "default" theme or the experimental "light" theme
    },
  },

  { import = "astrocommunity.debugging.nvim-bqf" },
  -- { import = "astrocommunity.completion.copilot-lua-cmp" },
}
