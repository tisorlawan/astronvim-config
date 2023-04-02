return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  { import = "astrocommunity.colorscheme.kanagawa",              enabled = true },
  { import = "astrocommunity.colorscheme.catppuccin",            enabled = true },
  { import = "astrocommunity.colorscheme.everforest",            enabled = true },
  { import = "astrocommunity.colorscheme.gruvbox",               enabled = true },
  { import = "astrocommunity.colorscheme.kanagawa",              enabled = true },
  { import = "astrocommunity.colorscheme.mini-base16",           enabled = true },
  { import = "astrocommunity.colorscheme.nightfox",              enabled = true },
  { import = "astrocommunity.colorscheme.onigiri",               enabled = true },
  { import = "astrocommunity.colorscheme.oxocarbon",             enabled = true },
  { import = "astrocommunity.colorscheme.rose-pine",             enabled = true },
  { import = "astrocommunity.colorscheme.tokyonight",            enabled = true },

  --
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.motion.mini-surround" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },

  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.svelte" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.typescript" },

  { import = "astrocommunity.debugging.nvim-bqf" },

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
}
