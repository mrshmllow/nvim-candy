local augroup = vim.api.nvim_create_augroup("marshcolorscheme", { clear = true })

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	pattern = "lackluster*",
	group = augroup,
	callback = function()
		local ls = require("lackluster")

		vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { bg = ls.color.gray3 })
		vim.api.nvim_set_hl(0, "MiniPickMatchRanges", { fg = ls.color.lack })
		vim.api.nvim_set_hl(0, "MiniPickPrompt", { fg = ls.color.lack })
		vim.api.nvim_set_hl(0, "MiniFilesDirectory", { fg = ls.color.lack })
		vim.api.nvim_set_hl(0, "MiniFilesTitleFocused", { fg = ls.color.lack })
		vim.api.nvim_set_hl(0, "MiniClueNextKey", { fg = ls.color.lack })
	end,
})

local hipatterns = require("mini.hipatterns")

hipatterns.setup({
	highlighters = {
		-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

		-- Highlight hex color strings (`#rrggbb`) using that color
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})
