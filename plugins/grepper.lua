return {
  "mhinz/vim-grepper",
  cmd = "Grepper",
  event = "BufRead",
  config = function()
    vim.cmd [[
		let g:grepper.tools = ['rg', 'git', 'ag']
	]]
    vim.g.grepper.quickfix = 1
  end,
}
