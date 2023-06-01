return {
  {
    "tamago324/lir.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
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
    end,
    enabled = false,
  },
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup {
        -- Id is automatically added at the beginning, and name at the end
        -- See :help oil-columns
        columns = {
          "icon",
          -- "permissions",
          -- "size",
          -- "mtime",
        },
        -- Buffer-local options to use for oil buffers
        buf_options = {
          buflisted = false,
          bufhidden = "hide",
        },
        -- Window-local options to use for oil buffers
        win_options = {
          wrap = false,
          signcolumn = "no",
          cursorcolumn = false,
          foldcolumn = "0",
          spell = false,
          list = false,
          conceallevel = 3,
          concealcursor = "n",
        },
        -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`
        default_file_explorer = true,
        -- Restore window options to previous values when leaving an oil buffer
        restore_win_options = true,
        -- Skip the confirmation popup for simple operations
        skip_confirm_for_simple_edits = false,
        -- Deleted files will be removed with the `trash-put` command.
        delete_to_trash = false,
        -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
        prompt_save_on_select_new_entry = true,
        -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
        -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
        -- Additionally, if it is a string that matches "actions.<name>",
        -- it will use the mapping at require("oil.actions").<name>
        -- Set to `false` to remove a keymap
        -- See :help oil-actions for a list of all available actions
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-s>"] = "actions.select_vsplit",
          ["<C-h>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["g."] = "actions.toggle_hidden",
        },
        -- Set to false to disable all of the above keymaps
        use_default_keymaps = true,
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = false,
          -- This function defines what is considered a "hidden" file
          is_hidden_file = function(name, bufnr) return vim.startswith(name, ".") end,
          -- This function defines what will never be shown, even when `show_hidden` is set
          is_always_hidden = function(name, bufnr) return false end,
        },
        -- Configuration for the floating window in oil.open_float
        float = {
          -- Padding around the floating window
          padding = 2,
          max_width = 0,
          max_height = 0,
          border = "rounded",
          win_options = {
            winblend = 10,
          },
        },
        -- Configuration for the actions floating preview window
        preview = {
          -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          -- min_width and max_width can be a single value or a list of mixed integer/float types.
          -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
          max_width = 0.9,
          -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
          min_width = { 40, 0.4 },
          -- optionally define an integer/float for the exact width of the preview window
          width = nil,
          -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          -- min_height and max_height can be a single value or a list of mixed integer/float types.
          -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
          max_height = 0.9,
          -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
          min_height = { 5, 0.1 },
          -- optionally define an integer/float for the exact height of the preview window
          height = nil,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
        },
        -- Configuration for the floating progress window
        progress = {
          max_width = 0.9,
          min_width = { 40, 0.4 },
          width = nil,
          max_height = { 10, 0.9 },
          min_height = { 5, 0.1 },
          height = nil,
          border = "rounded",
          minimized_border = "none",
          win_options = {
            winblend = 0,
          },
        },
      }
    end,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    enabled = false,
  },
}
