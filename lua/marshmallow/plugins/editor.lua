return {
	{
		"phaazon/hop.nvim",
		branch = "v2",
		opts = {
			keys = "etovxqpdygfblzhckisuran",
			jump_on_sole_occurrence = true,
		},
		keys = {
			{
				"f",
				function()
					require("hop").hint_char1({
						direction = require("hop.hint").HintDirection.AFTER_CURSOR,
						current_line_only = true,
					})
				end,
				mode = "",
			},
			{
				"W",
				function()
					require("hop").hint_words()
				end,
			},
			{
				"F",
				function()
					require("hop").hint_char1({
						direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
						current_line_only = true,
					})
				end,
				mode = "",
			},
			{
				"t",
				function()
					require("hop").hint_char1({
						direction = require("hop.hint").HintDirection.AFTER_CURSOR,
						current_line_only = true,
						hint_offset = -1,
					})
				end,
				mode = "",
			},
			{
				"T",
				function()
					require("hop").hint_char1({
						direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
						current_line_only = true,
						hint_offset = 1,
					})
				end,
				mode = "",
			},
		},
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
	{
		"Ron89/thesaurus_query.vim",
		keys = {
			{
				"<Leader>cs",
			},
		},
    cmd = {
      "Thesaurus",
      "ThesaurusQuery",
      "ThesaurusReplace",
      "ThesaurusLookup",
      "ThesaurusQueryLookupCurrentWord",
      "ThesaurusReplaceLookupCurrentWord",
    }
	},
	-- {
	--   "zbirenbaum/copilot.lua",
	--   cmd = "Copilot",
	--   event = "InsertEnter",
	--   opts = {}
	-- },
}
