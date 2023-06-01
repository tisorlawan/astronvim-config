-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
--
return {
  -- first key is the mode
  i = {
    ["<C-l>"] = { "<Right>" },
    ["<C-h>"] = { "<Left>" },
    ["<C-o><C-o>"] = { "<ESC>o" },
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
    -- ["-"] = { require("user.utils").edit_filedir, desc = "Lir" },
    -- ["-"] = { "<cmd>lua require'lir.float'.toggle()<CR>", desc = "Lir float" },
    -- ["-"] = { require("oil").open, desc = "Open parent directory" },
    ["<leader>xn"] = { require("user.utils").create_buffer, desc = "Create adjacent file" },
    -- Dotfiles
    ["<leader>fd"] = { require("user.utils").find_dotfiles, desc = "Find dotfiles" },
    ["<leader><tab>"] = { "<C-^>", desc = "Alternative buffer" },
    -- Harpoon
    ["<leader>h"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", desc = "Harpoon toogle menu" },
    ["<leader>a"] = { "<cmd>lua require('harpoon.mark').add_file()<CR>", desc = "Harpoon add mark" },
    ["<leader>fs"] = { "<cmd>Telescope harpoon marks<CR>", desc = "Telescope harpoon" },
    ["<C-n>"] = { "<cmd>lua require('harpoon.ui').nav_next()<CR>" },
    ["<C-p>"] = { "<cmd>lua require('harpoon.ui').nav_prev()<CR>" },
    -- Buffer manipulation
    ["<M-n>"] = { "<cmd>bnext<CR>" },
    ["<M-p>"] = { "<cmd>bprev<CR>" },
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
    ["<leader>qq"] = { "<cmd>Grepper -tool rg<CR>", desc = "Grepper" },
    -- Navbuddy
    -- ["<leader>nv"] = { "<cmd>Navbuddy<CR>", desc = "Navbuddy" },
    -- NvimTree
    ["<leader>e"] = { "<cmd>NvimTreeFindFileToggle<CR>", desc = "NvimTreeToggle" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
