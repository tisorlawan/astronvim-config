local kind_icons = {
  Text = "",
  Method = "󰊕 ",
  Function = "󰊕",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "  ",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = " ",
  TypeParameter = " ",
}
-- Namespace = " ",
-- Package = " ",
-- Enum = "",
-- Constant = " ",
-- String = " ",
-- Number = " ",
-- Boolean = "◩ ",
-- Array = " ",
-- Object = " ",
-- Key = " ",
-- Null = "󰟢 ",
-- EnumMember = " ",
-- Struct = " ",
-- Event = " ",
-- Operator = " ",
-- TypeParameter = " ",

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

return {
  -- override nvim-cmp plugin
  "hrsh7th/nvim-cmp",
  -- override the options table that is used in the `require("cmp").setup()` call
  opts = function(_, opts)
    -- opts parameter is the default options table
    -- the function is lazy loaded so cmp is able to be required
    local cmp = require "cmp"
    -- modify the mapping part of the table
    opts.mapping["<C-x>"] = cmp.mapping.select_next_item()

    -- opts.formatting = {
    --   format = function(entry, vim_item)
    --     -- Kind icons
    --     -- vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
    --     vim_item.kind = string.format("%s", kind_icons[vim_item.kind]) -- This concatonates the icons with the name of the item kind
    --     -- -- Source
    --     -- vim_item.menu = ({
    --     --   nvim_lsp = "[L]",
    --     --   buffer = "[B]",
    --     --   luasnip = "[S]",
    --     --   nvim_lua = "[Lua]",
    --     --   treesitter = "[T]",
    --     --   path = "[P]",
    --     --   nvim_lsp_signature_help = "[S]",
    --     -- })[entry.source.name]
    --     return vim_item
    --   end,
    -- }

    opts.window = {
      completion = {
        border = border "CmpBorder",
        winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
      },
      documentation = {
        border = border "CmpDocBorder",
      },
    }

    -- return the new table to be used
    return opts
  end,
}
