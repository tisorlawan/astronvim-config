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

return M
