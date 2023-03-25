local M = {}

function M.setup()
  vim.cmd([[
		let g:grepper.tools = ['rg', 'git', 'ag']
	]])
  vim.g.grepper.quickfix = 1
end

return M
