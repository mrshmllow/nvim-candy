require("catppuccin").setup({
	term_colors = true,
	custom_highlights = function(colors)
		return {
			StatusLine = { bg = colors.base },


			MiniMapDiagnosticError = { bg = colors.red, fg = colors.red },
			MiniMapDiagnosticWarn = { bg = colors.yellow, fg = colors.yellow },
			MiniMapDiagnosticInfo = { bg = colors.teal, fg = colors.teal },
			MiniMapDiagnosticHint = {},

			MiniFilesBorder = { fg = colors.surface0 },
			MiniFilesNormal = { bg = colors.base },

			MiniPickBorder = { fg = colors.surface0 },
			MiniPickNormal = { bg = colors.base },
			MiniPickPrompt = { fg = colors.mauve },

			FloatBorder = { fg = colors.mauve },

			Directory = { fg = colors.mauve },

			-- native_lsp method doesnt work?
			LspInlayHint = { fg = colors.overlay0, bg = colors.base },
		}
	end,
})

vim.cmd.colorscheme("catppuccin")
