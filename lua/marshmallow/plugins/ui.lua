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
				m = {
					name = "Map",
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
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			space_char_blankline = " ",
			show_current_context = true,
			char = "▎",
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
			{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
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
			{ "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
			{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
			{ "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{
				"<leader>sc",
				Util.telescope("live_grep", { cwd = "~/.config/nvim" }),
				desc = "Search in ~/.config/nvim",
			},
			{ "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
			{ "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
			{ "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
			{
				"<leader>sH",
				"<cmd>Telescope highlights<cr>",
				desc = "Search Highlight Groups",
			},
			{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
			{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
			{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
			{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
			{ "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
			{ "<leader>sl", "<cmd>Telescope symbols<cr>", desc = "Symbols" },
			{ "<leader>sw", Util.telescope("grep_string"), desc = "Word (root dir)" },
			{ "<leader>sW", Util.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
			{
				"<leader>ss",
				Util.telescope("lsp_document_symbols", {
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
				desc = "Goto Symbol",
			},
			{
				"<leader>sS",
				Util.telescope("lsp_workspace_symbols", {
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
				desc = "Goto Symbol (Workspace)",
			},
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
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
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
		"echasnovski/mini.map",
		version = false,
		dependencies = "lewis6991/gitsigns.nvim",
		keys = {
			{
				"<Leader>mc",
				function()
					require("mini.map").close()
				end,
				desc = "Close Map",
			},
			{
				"<Leader>mf",
				function()
					require("mini.map").toggle_focus()
				end,
				desc = "Toggle Map Focus",
			},
			{
				"<Leader>mo",
				function()
					require("mini.map").open()
				end,
				desc = "Open Map",
			},
			{
				"<Leader>mr",
				function()
					require("mini.map").refresh()
				end,
				desc = "Refresh Map",
			},
			{
				"<Leader>ms",
				function()
					require("mini.map").toggle_side()
				end,
				desc = "Toggle Map Side",
			},
			{
				"<Leader>mt",
				function()
					require("mini.map").toggle()
				end,
				desc = "Toggle Map",
			},
		},
		config = function()
			local map = require("mini.map")

			for _, key in ipairs({ "n", "N", "*", "#" }) do
				vim.keymap.set("n", key, key .. "<Cmd>lua MiniMap.refresh({}, {lines = false, scrollbar = false})<CR>")
			end

			map.setup({
				integrations = {
					map.gen_integration.builtin_search({
						search = "MiniMapSearch",
					}),
					map.gen_integration.diagnostic({
						error = "MiniMapDiagnosticError",
						warn = "MiniMapDiagnosticWarn",
						info = "MiniMapDiagnosticInfo",
						hint = nil,
					}),
					map.gen_integration.gitsigns({
						add = "GitSignsAdd",
						change = "GitSignsChange",
						delete = "GitSignsDelete",
					}),
				},
				symbols = {
					encode = map.gen_encode_symbols.block("3x2"),

					-- Scrollbar parts for view and line. Use empty string to disable any.
					scroll_line = "┃",
					scroll_view = "┃",
				},

				window = {
					show_integration_count = false,
				},
			})
		end,
	},
	{
		"echasnovski/mini.surround",
		version = false,
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
	-- {
	-- 	"stevearc/oil.nvim",
	-- 	dependencies = {
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- 	opts = {
	-- 		columns = {
	-- 			"icon",
	-- 		},
	-- 		trash_command = "gio trash",
	-- 		delete_to_trash = true,
	-- 		keymaps = {
	-- 			["g?"] = "actions.show_help",
	-- 			["<CR>"] = "actions.select",
	-- 			["<C-v>"] = "actions.select_vsplit",
	-- 			["<C-s>"] = false,
	-- 			["<C-h>"] = false,
	-- 			["<C-t>"] = "actions.select_tab",
	-- 			["<C-p>"] = "actions.preview",
	-- 			["<C-c>"] = false,
	-- 			["<C-l>"] = false,
	-- 			["-"] = "actions.parent",
	-- 			["_"] = "actions.open_cwd",
	-- 			["`"] = "actions.cd",
	-- 			["~"] = "actions.tcd",
	-- 			["g."] = "actions.toggle_hidden",
	-- 		},
	-- 	},
	-- 	keys = {
	-- 		{
	-- 			"-",
	-- 			function()
	-- 				require("oil").open()
	-- 			end,
	-- 			desc = "Open parent directory",
	-- 		},
	-- 	},
	-- },
	{
		"echasnovski/mini.files",
		version = false,
		opts = {
			options = {
				use_as_default_explorer = true,
			},
			windows = {
				preview = true,
			},
		},
		keys = {
			{
				"-",
				function()
					require("mini.files").open()
				end,
			},
		},
		config = function(_, opts)
			require("mini.files").setup(opts)

			local show_dotfiles = true

			local filter_show = function(fs_entry)
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
		"tpope/vim-dadbod",
		dependencies = {
			"kristijanhusak/vim-dadbod-ui",
		},
		cmd = {
			"DB",
			"DBUIClose",
			"DBUIToggle",
			"DBUIFindBuffer",
			"DBUIRenameBuffer",
			"DBUIAddConnection",
			"DBUILastQueryInfo",
		},
	},
	-- {
	--   "echasnovski/mini.starter",
	--   version = false,
	--   opts = {},
	--   config = function()
	--     local starter = require("mini.starter")

	--     local function footer()
	--       local timer = vim.loop.new_timer()

	--       timer:start(
	--         0,
	--         1000,
	--         vim.schedule_wrap(function()
	--           if vim.api.nvim_buf_get_option(0, "filetype") == "starter" then
	--             starter.refresh()
	--             timer:close()
	--           end
	--         end)
	--       )

	--       return function()
	--         local stats = require("lazy").stats()

	--         return "Loaded in ~" .. math.floor(stats.startuptime + 0.5)
	--       end
	--     end

	--     require("mini.starter").setup({
	--       header = function()
	--         return table.concat({}, "\n")
	--       end,
	--       footer = footer(),
	--       items = {
	--         starter.sections.recent_files(5, true, false),
	--         starter.sections.sessions(),
	--       },
	--       evaluate_single = true,
	--     })
	--   end,
	-- },
	{
		"echasnovski/mini.sessions",
		version = false,
		opts = {},
		keys = {
			{
				"<leader>Sr",
				function()
					require("mini.sessions").select()
				end,
				desc = "Read Session",
			},
			{
				"<leader>Sd",
				function()
					require("mini.sessions").select("delete")
				end,
				desc = "Delete Session",
			},
			{
				"<leader>Sw",
				function()
					local name = vim.fn.input({ prompt = "Session name (optional): ", default = "" })

					require("mini.sessions").write(name == "" and nil or name)
				end,
				desc = "Write Session",
			},
		},
		lazy = false,
	},
	{
		"m4xshen/smartcolumn.nvim",
		opts = {
			{ "lazy", "help", "minifiles" },
		},
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"tpope/vim-fugitive",
		lazy = false,
	},
}
