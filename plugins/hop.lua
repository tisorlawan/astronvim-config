return {
	"phaazon/hop.nvim",
	cmd = { "HopWord", "HopChar1" },
	keys = { "f", "F", "t", "T" },
	config = function() require("user.configs.hop").setup() end,
}
