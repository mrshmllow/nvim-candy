return {
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").create_default_mappings()
		end,
	},
	{
		"chrisgrieser/nvim-spider",
		opts = {
			skipInsignificantPunctuation = false,
		},
		keys = {
			{
				"w",
				"<cmd>lua require('spider').motion('w')<CR>",
				mode = { "n", "o", "x" },
			},
			{
				"e",
				"<cmd>lua require('spider').motion('e')<CR>",
				mode = { "n", "o", "x" },
			},
			{
				"b",
				"<cmd>lua require('spider').motion('b')<CR>",
				mode = { "n", "o", "x" },
			},
			{
				"ge",
				"<cmd>lua require('spider').motion('ge')<CR>",
				mode = { "n", "o", "x" },
				{ desc = "Spider-ge" },
			},
		},
	},
	{
		"mbbill/undotree",
		cmd = { "UndotreeToggle", "UndotreeFocus", "UndotreeShow", "UndotreeHide" },
	},
}
