local lir = require "lir"
local actions = require "lir.actions"
local mark_actions = require "lir.mark.actions"
local clipboard_actions = require "lir.clipboard.actions"

local function goto_git_root()
  local dir = require("lspconfig.util").find_git_ancestor(vim.fn.getcwd())
  if dir == nil or dir == "" then return end
  vim.cmd("e " .. dir)
end

local utils = lir.utils
local config = lir.config
local Path = require "plenary.path"

local function lcd(path) vim.cmd(string.format(":lcd %s", path)) end

local no_confirm_patterns = {
  "^LICENSE$",
  "^Makefile$",
}

local need_confirm = function(filename)
  for _, pattern in ipairs(no_confirm_patterns) do
    if filename:match(pattern) then return false end
  end
  return true
end

local function input_newfile()
  local save_curdir = vim.fn.getcwd()
  lcd(lir.get_context().dir)
  local name = vim.fn.input("New file: ", "", "file")
  lcd(save_curdir)

  if name == "" then return end

  if name == "." or name == ".." then
    utils.error("Invalid file name: " .. name)
    return
  end

  -- If I need to check, I will.
  if need_confirm(name) then
    -- '.' is not included or '/' is not included, then
    -- I may have entered it as a directory, I'll check.
    if not name:match "%." and not name:match "/" then
      if vim.fn.confirm("Directory?", "&No\n&Yes", 1) == 2 then name = name .. "/" end
    end
  end

  local path = Path:new(lir.get_context().dir .. name)
  if string.match(name, "/$") then
    -- mkdir
    name = name:gsub("/$", "")
    path:mkdir {
      parents = true,
      mode = tonumber("700", 8),
      exists_ok = false,
    }
  else
    -- touch
    path:touch {
      parents = true,
      mode = tonumber("644", 8),
    }
  end

  -- If the first character is '.' and show_hidden_files is false, set it to true
  if name:match [[^%.]] and not config.values.show_hidden_files then config.values.show_hidden_files = true end

  actions.reload()

  -- Jump to a line in the parent directory of the file you created.
  local lnum = lir.get_context():indexof(name:match "^[^/]+")
  if lnum then vim.cmd(tostring(lnum)) end
end

local M = {}
function M.setup()
  require("lir").setup {
    show_hidden_files = false,
    devicons = {
      enable = false,
      highlight_dirname = false,
    },
    mappings = {
      ["l"] = actions.edit,
      ["<CR>"] = actions.edit,
      ["<C-s>"] = actions.split,
      ["<C-v>"] = actions.vsplit,
      ["<C-t>"] = actions.tabedit,
      ["h"] = actions.up,
      ["q"] = actions.quit,
      ["K"] = actions.mkdir,
      ["N"] = input_newfile,
      ["R"] = actions.rename,
      ["@"] = actions.cd,
      ["Y"] = actions.yank_path,
      ["."] = actions.toggle_show_hidden,
      ["D"] = actions.delete,
      ["J"] = function()
        mark_actions.toggle_mark()
        vim.cmd "normal! j"
      end,
      ["C"] = clipboard_actions.copy,
      ["X"] = clipboard_actions.cut,
      ["P"] = clipboard_actions.paste,
      ["g"] = goto_git_root,
    },
    float = {
      winblend = 0,
      curdir_window = {
        enable = true,
        highlight_dirname = true,
      },
      win_opts = function()
        return {
          border = {
            "+",
            "─",
            "+",
            "│",
            "+",
            "─",
            "+",
            "│",
          },
        }
      end,
    },
    hide_cursor = false,
    on_init = function()
      -- use visual mode
      vim.api.nvim_buf_set_keymap(
        0,
        "x",
        "J",
        ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
        { noremap = true, silent = true }
      )
    end,
  }
end

return M
