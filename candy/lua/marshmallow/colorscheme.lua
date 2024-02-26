require("catppuccin").setup({
	term_colors = true,
	custom_highlights = function(colors)
		return {
			StatusLine = { bg = colors.base },


			MiniMapDiagnosticError = { bg = colors.red, fg = colors.red },
			MiniMapDiagnosticWarn = { bg = colors.yellow, fg = colors.yellow },
			MiniMapDiagnosticInfo = { bg = colors.teal, fg = colors.teal },
			MiniMapDiagnosticHint = {},
			Directory = { fg = colors.mauve },
		}
	end,
})

vim.cmd.colorscheme("catppuccin")
