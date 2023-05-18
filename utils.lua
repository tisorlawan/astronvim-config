local M = {}

function M.create_buffer()
  local dir = vim.fn.expand "%:p:h"

  local filename = vim.fn.input(dir .. "/")
  filename = filename:gsub("^%s*(.-)%s*$", "%1")

  vim.cmd 'echo ""'
  if filename ~= nil and filename ~= "" then
    local filepath = dir .. "/" .. filename
    vim.cmd("e " .. filepath)
    print("Created buffer " .. filepath)
  else
    vim.cmd 'echo ""'
  end
end

function M.edit_filedir()
  local dir = vim.fn.expand "%:p:h"

  vim.cmd("edit " .. dir)
end

function M.SemiColonConfig()
  vim.cmd [[
		inoremap <buffer> <C-d> <End>;
	]]
end

function M.find_dotfiles()
  require("telescope.builtin").git_files {
    prompt_title = "<Dotfiles>",
    cwd = "$HOME/.rice/",
  }
end

return M
