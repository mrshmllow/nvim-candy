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
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = vim.fn.executable("make") == 1,
			},
			"nvim-telescope/telescope-symbols.nvim",
		},
		keys = {
			{ "<leader><space>", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
			{
				"<leader>/",
				Util.telescope("live_grep"),
				desc = "Find in Files (Grep)",
			},
			-- find
			{
				"<leader>ff",
				Util.telescope("files"),
				desc = "Find Files (root dir)",
			},
			{ "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
			{
				"<leader>fc",
				Util.telescope("find_files", { cwd = "~/.config/nvim" }),
				desc = "Find Files (~/.config/nvim)",
			},
			{
				"<leader>fC",
				Util.telescope("find_files", { cwd = "~/.config/" }),
				desc = "Find Files (~/.config/)",
			},
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
			-- search
			{
				"<leader>sc",
				Util.telescope("live_grep", { cwd = "~/.config/nvim" }),
				desc = "Search in ~/.config/nvim",
			},
			{ "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
			{ "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
			{
				"<leader>sH",
				"<cmd>Telescope highlights<cr>",
				desc = "Search Highlight Groups",
			},
			{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
			{ "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
		},
		config = function()
			require("telescope").setup({})

			pcall(require("telescope").load_extension, "fzf")
		end,
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
		"voldikss/vim-floaterm",
		cmd = "FloatermNew",
		lazy = true,
		keys = {
			{
				"<leader>tl",
				"<cmd>:FloatermNew --cwd=<root> --name=Lazygit --width=1.0 --height=1.0  lazygit<CR>",
				desc = "Open Lazygit",
			},
		},
	},
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>a",
				function()
					require("harpoon.mark").add_file()
				end,
				desc = "Harpoon file",
			},
			{
				"<leader><C-space>",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
				desc = "Open Harpoon",
			},
			{
				"<leader>h",
				function()
					require("harpoon.ui").nav_prev()
				end,
				desc = "Harpoon prev",
			},
			{
				"<leader>l",
				function()
					require("harpoon.ui").nav_next()
				end,
				desc = "Harpoon next",
			},
		},
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
					require("mini.files").open(require("mini.files").open(vim.api.nvim_buf_get_name(0)))
				end,
				"_",
				function()
					require("mini.files").open(require("mini.files").get_latest_path())
				end,
			},
		},
		config = function(_, opts)
			require("mini.files").setup(opts)

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
				callback = function(args)
					local buf_id = args.data.buf_id
					vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
				end,
			})
		end,
	},
	{
		"m4xshen/smartcolumn.nvim",
		opts = {
			{ "lazy", "help", "minifiles" },
		},
		event = { "BufReadPre", "BufNewFile" },
	},
}
