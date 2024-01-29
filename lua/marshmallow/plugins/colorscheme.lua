return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		flavour = vim.env.LAUNCH_CATPPUCCIN and vim.env.LAUNCH_CATPPUCCIN or "mocha",
		term_colors = true,
		-- transparent_background = true,
		show_end_of_buffer = false,
		intergration = {
			neogit = true,
			gitsigns = true,
			treesitter_context = true,
			hop = true,
			mini = true,
			harpoon = true,
			headlines = true,
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

				MiniFilesBorder = { fg = colors.surface0 },
				MiniFilesNormal = { bg = colors.base },

				MiniPickBorder = { fg = colors.surface0 },
				MiniPickNormal = { bg = colors.base },
				MiniPickPrompt = { fg = colors.mauve },

				FloatBorder = { fg = colors.mauve },

				Directory = { fg = colors.mauve },
				IblScope = { fg = colors.surface2 },

				-- native_lsp method doesnt work?
				LspInlayHint = { fg = colors.overlay0, bg = colors.base },
			}
		end,
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)

		vim.cmd.colorscheme("catppuccin")
	end,
}
