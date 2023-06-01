return {
	"phaazon/hop.nvim",
	cmd = { "HopWord", "HopChar1" },
	keys = { "f", "F", "t", "T" },
	config = function()
		require("hop").setup {
			keys = "etovxqpdygfblzhckisuran",
			case_insensitive = false,
		}

		-- Remap f,F,t,T
		-- vim.api.nvim_set_keymap(
		--   "",
		--   "f",
		--   "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
		--   {}
		-- )
		-- vim.api.nvim_set_keymap(
		--   "",
		--   "F",
		--   "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
		--   {}
		-- )
		-- vim.api.nvim_set_keymap(
		--   "",
		--   "t",
		--   "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
		--   {}
		-- )
		-- vim.api.nvim_set_keymap(
		--   "",
		--   "T",
		--   "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>",
		--   {}
		-- )
	end,
}
