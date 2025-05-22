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
