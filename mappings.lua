-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  i = {
    ["<C-l>"] = { "<Right>" },
    ["<C-h>"] = { "<Left>" },
  },
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command
    -- [[<Cmd>execute 'e ' .. expand('%:p:h')<CR>]]
    ["-"] = { "<cmd>lua require'lir.float'.toggle()<CR>", desc = "Lir" },
    ["<leader>xn"] = { require("user.utils").create_buffer, desc = "Create adjacent file" },
    ["<leader><tab>"] = { "<C-^>", desc = "Toggle buffer" },
    -- Hop
    ["<leader>s"] = { "<cmd>HopChar1<Cr>", desc = "Hop 1 Character" },
    -- Neogit
    ["<leader>gg"] = { "<cmd>Neogit<Cr>", desc = "Neogit" },
    -- Quicklist
    ["cn"] = { ":cnext<CR>" },
    ["cp"] = { ":cprev<CR>" },
    ["co"] = { ":copen<CR>" },
    ["cq"] = { ":cclose<CR>" },
    -- Grepper
    ["<leader>qq"] = { "<cmd>Grepper -tool rg<CR>", desc = "Grepper" }
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
