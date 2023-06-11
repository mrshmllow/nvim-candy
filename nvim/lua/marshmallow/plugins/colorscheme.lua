return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		flavour = "mocha",
		term_colors = true,
		-- transparent_background = true,
		intergration = {
			neotree = true,
			gitsigns = true,
			treesitter_context = true,
			treesitter = true,
			hop = true,
			mini = true,
		},
		custom_highlights = function(colors)
			return {
				StatusLine = { bg = colors.base },

				MiniCursorword = { bg = colors.surface1 },

				MiniMapSearch = { fg = colors.mauve, bg = colors.surface1 },

				MiniMapDiagnosticError = { bg = colors.red, fg = colors.red },
				MiniMapDiagnosticWarn = { bg = colors.yellow, fg = colors.yellow },
				MiniMapDiagnosticInfo = { bg = colors.teal, fg = colors.teal },
				MiniMapDiagnosticHint = {},

				MiniMapNormal = { fg = colors.surface0 },
				MiniMapSymbolCount = { fg = colors.mauve },
				MiniMapSymbolLine = { fg = colors.surface2 },
				MiniMapSymbolView = { fg = colors.surface0 },
			}
		end,
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)

		vim.cmd.colorscheme("catppuccin")
	end,
}
