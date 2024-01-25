local Util = require("marshmallow.util")

return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup({
				spelling = {
					enabled = false,
				},
			})

			require("which-key").register({
				f = {
					name = "Find",
				},
				g = {
					name = "Git",
				},
				s = {
					name = "Search",
				},
				c = {
					name = "Change",
				},
				t = {
					name = "Open term",
				},
				o = {
					name = "Org Mode",
				},
				S = {
					name = "Sessions",
				},
			}, { prefix = "<leader>" })
		end,
	},
	{
		"Eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
	},
	{
		"gbprod/stay-in-place.nvim",
		opts = true,
		event = "VeryLazy",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		name = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			indent = {
				char = "▎",
			},
		},
	},
	{
		"echasnovski/mini.pick",
		lazy = false,
		config = function()
			require("mini.pick").setup()
		end,
		keys = {
			{
				"<leader>f",
				function()
					require("mini.pick").builtin.files()
				end,
				desc = "Find Files (root dir)",
			},
			{
				"<leader>/",
				function()
					require("mini.pick").builtin.grep_live()
				end,
				desc = "Find in Files (Grep)",
			},
			{
				"<leader><space>",
				function()
					local wipeout_cur = function()
						vim.api.nvim_buf_delete(require("mini.pick").get_picker_matches().current.bufnr, {})
					end
					local buffer_mappings = { wipeout = { char = "<C-d>", func = wipeout_cur } }
					require("mini.pick").builtin.buffers({
						include_current = false,
					}, { mappings = buffer_mappings })
				end,
				desc = "Switch Buffer",
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			_signs_staged_enable = true,
			preview_config = {
				border = "rounded",
			},
			-- signs_staged_enable = true,
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		opts = true,
		keys = {
			{ "<leader>st", "<cmd>TodoTelescope<CR>", desc = "Todo Comments" },
		},
	},
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {},
		version = false,
	},
	{
		"echasnovski/mini.move",
		version = false,
		keys = {
			"<M-h>",
			"<M-l>",
			"<M-j>",
			"<M-k>",
			{
				"<M-h>",
				mode = "v",
			},
			{
				"<M-l>",
				mode = "v",
			},
			{
				"<M-j>",
				mode = "v",
			},
			{
				"<M-h>",
				mode = "v",
			},
		},
		opts = {},
	},
	{
		"echasnovski/mini.surround",
		version = false,
		lazy = false,
		keys = {
			"gza",
			"gzd",
			"gzf",
			"gzF",
			"gzh",
			"gzr",
			"gzn",
		},
		opts = {
			mappings = {
				add = "gza", -- Add surrounding in Normal and Visual modes
				delete = "gzd", -- Delete surrounding
				find = "gzf", -- Find surrounding (to the right)
				find_left = "gzF", -- Find surrounding (to the left)
				highlight = "gzh", -- Highlight surrounding
				replace = "gzr", -- Replace surrounding
				update_n_lines = "gzn", -- Update `n_lines`
			},
		},
	},
	{
		"echasnovski/mini.comment",
		version = false,
		keys = {
			"gc",
			"gcc",
			{
				"gcc",
				mode = "v",
			},
		},
		opts = true,
	},
	{
		"echasnovski/mini.cursorword",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.cursorword").setup()

			vim.cmd(":hi! MiniCursorwordCurrent guifg=NONE guibg=NONE gui=NONE cterm=NONE")
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		opts = true,
		event = "VeryLazy",
	},
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		branch = "harpoon2",
		opts = true,
		keys = function()
			local keys = {
				{
					"<leader>a",
					function()
						require("harpoon"):list():append()
						vim.notify("Harpooned file", vim.log.levels.INFO)
					end,
					desc = "Harpoon file",
				},
				{
					"<leader><C-space>",
					function()
						require("harpoon"):toggle_quick_menu(require("harpoon"):list())
					end,
					desc = "Open Harpoon",
				},
			}

			for i = 1, 5 do
				vim.list_extend(keys, {
					{
						"<M-" .. i .. ">",
						function()
							require("harpoon"):list():select(i)
						end,
					},
				})
			end

			return keys
		end,
	},
	{
		"echasnovski/mini.files",
		version = false,
		opts = {
			options = {
				use_as_default_explorer = true,
				permanant_delete = false,
			},
			windows = {
				preview = true,
			},
		},
		keys = {
			{
				"-",
				function()
					require("mini.files").open(vim.api.nvim_buf_get_name(0))
				end,
			},
		},
		config = function(_, opts)
			require("mini.files").setup(opts)

			local id = vim.api.nvim_create_augroup("MarshmallowMiniFiles", {
				clear = true,
			})

			local show_dotfiles = true

			local filter_show = function()
				return true
			end

			local filter_hide = function(fs_entry)
				return not vim.startswith(fs_entry.name, ".")
			end

			local toggle_dotfiles = function()
				show_dotfiles = not show_dotfiles
				local new_filter = show_dotfiles and filter_show or filter_hide
				require("mini.files").refresh({ content = { filter = new_filter } })
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				group = id,
				callback = function(args)
					local buf_id = args.data.buf_id
					vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle dotfiles" })
				end,
			})
		end,
	},
	{
		"m4xshen/smartcolumn.nvim",
		opts = {
			{ "lazy", "help", "minifiles", "markdown", "qf", "checkhealth" },
		},
		event = { "BufReadPre", "BufNewFile" },
	},
}
