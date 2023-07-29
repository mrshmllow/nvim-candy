return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			{
				"nvim-treesitter/nvim-treesitter-context",
				opts = {
					max_lines = 2,
					mode = "topline",
				},
			},
			"nvim-treesitter/playground",
		},
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		version = false,
		config = function()
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldenable = false

			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"cpp",
					"go",
					"lua",
					"python",
					"rust",
					"typescript",
					"vim",
					"tsx",
					"javascript",
					"css",
					"org",
					"nix",
					"json",
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = {
						"org",
					},
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<c-space>",
						node_incremental = "<c-space>",
						scope_incremental = "<c-s>",
						node_decremental = "<c-backspace>",
					},
				},
				indent = { enable = true, disable = { "python" } },
				swap = {
					enable = true,
					swap_next = {
						["<leader>."] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>,"] = "@parameter.inner",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>."] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>,"] = "@parameter.inner",
						},
					},
				},
				playground = {
					enable = true,
					disable = {},
					updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
					persist_queries = false, -- Whether the query persists across vim sessions
					keybindings = {
						toggle_query_editor = "o",
						toggle_hl_groups = "i",
						toggle_injected_languages = "t",
						toggle_anonymous_nodes = "a",
						toggle_language_display = "I",
						focus_language = "f",
						unfocus_language = "F",
						update = "R",
						goto_node = "<cr>",
						show_help = "?",
					},
				},
			})
		end,
	},
}
