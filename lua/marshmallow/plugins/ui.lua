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
			{
				"<leader>tc",
				"<cmd>:FloatermNew --cwd=<root> --name=Chezmoi --width=1.0 --height=1.0 --auto_close=0 chezmoi cd<CR>",
				desc = "Open chezmoi",
			},
		},
	},
	{
		"rebelot/heirline.nvim",
		dependencies = { "catppuccin/nvim", "nvim-tree/nvim-web-devicons", "lewis6991/gitsigns.nvim" },
		event = "UiEnter",
		config = function()
			local heirline = require("heirline")
			local conditions = require("heirline.conditions")
			local utils = require("heirline.utils")

			local function get_colors()
				local palette = require("catppuccin.palettes").get_palette()

				return vim.tbl_extend("keep", {
					bg = palette.base,
					fg = palette.text,
				}, palette)
			end

			vim.api.nvim_create_augroup("Heirline", { clear = true })
			vim.api.nvim_create_autocmd("OptionSet", {
				pattern = "background",
				callback = function()
					require("heirline").load_colors(get_colors())
				end,
				group = "Heirline",
			})

			local ViMode = {
				init = function(self)
					self.mode = vim.fn.mode(1)
				end,
				provider = function(self)
					return "󱥰 " .. self.mode_names[self.mode] .. ""
				end,
				hl = function(self)
					local mode = self.mode:sub(1, 1)
					return { fg = self.mode_colors[mode], bold = true }
				end,
				update = {
					"ModeChanged",
					pattern = "*:*",
					callback = vim.schedule_wrap(function()
						vim.cmd("redrawstatus")
					end),
				},
			}

			ViMode = utils.surround({ "", "" }, "surface0", { ViMode })

			local FileNameBlock = {
				init = function(self)
					self.filename = vim.api.nvim_buf_get_name(0)
				end,
			}

			local FileIcon = {
				init = function(self)
					local filename = self.filename
					local extension = vim.fn.fnamemodify(filename, ":e")
					self.icon, self.icon_color =
						require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
				end,
				provider = function(self)
					return self.icon and (self.icon .. " ")
				end,
				hl = function(self)
					return { fg = self.icon_color }
				end,
			}

			local FileName = {
				provider = function(self)
					local filename = vim.fn.fnamemodify(self.filename, ":.")

					if vim.bo.filetype == "oil" then
						filename = vim.fn.fnamemodify(require("oil").get_current_dir(), ":p:~")
					end

					if filename == "" then
						return "[No Name]"
					end

					if not conditions.width_percent_below(#filename, 0.25) then
						filename = vim.fn.pathshorten(filename)
					end
					return filename
				end,
				hl = { fg = utils.get_highlight("Directory").fg },
			}

			local FileFlags = {
				{
					condition = function()
						return vim.bo.modified
					end,
					provider = "[+]",
					hl = { fg = "green" },
				},
				{
					condition = function()
						return not vim.bo.modifiable or vim.bo.readonly
					end,
					provider = " ",
					hl = { fg = "orange" },
				},
			}

			local FileNameModifer = {
				hl = function()
					if vim.bo.modified then
						return { fg = "cyan", bold = true, force = true }
					end
				end,
			}

			FileNameBlock = utils.insert(
				FileNameBlock,
				FileIcon,
				utils.insert(FileNameModifer, FileName),
				FileFlags,
				{ provider = "%<" }
			)

			local FileType = {
				provider = function()
					return string.upper(vim.bo.filetype)
				end,
				hl = { fg = utils.get_highlight("Type").fg, bold = true },
			}

			local Ruler = {
				-- %l = current line number
				-- %L = number of lines in the buffer
				-- %c = column number
				-- %P = percentage through file of displayed window
				provider = "%7(%l/%3L%):%2c %P",
				hl = {
					fg = "subtext0",
				},
			}

			local WordCount = {
				init = function(self)
					self.is_visual = vim.fn.mode() == "V"
				end,
				condition = function()
					return vim.b.show_word_count
				end,
				provider = function(self)
					local wc = vim.fn.wordcount()

					if self.is_visual then
						wc = wc.visual_words
					else
						wc = wc.words
					end

					return wc .. " words "
				end,
				hl = function(self)
					return { fg = "subtext0", bold = self.is_visual }
				end,
			}

			local LSPActive = {
				condition = conditions.lsp_attached,
				update = { "LspAttach", "LspDetach" },
				provider = function()
					local names = {}
					for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
						table.insert(names, server.name)
					end
					return table.concat(names, " ")
				end,
				hl = { fg = "green", bold = true },
			}

			local Diagnostics = {
				condition = conditions.has_diagnostics,
				static = {
					error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
					warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
					info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
					hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
				},
				init = function(self)
					self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
					self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
					self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
					self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
				end,
				update = { "DiagnosticChanged", "BufEnter" },
				{
					provider = function(self)
						-- 0 is just another output, we can decide to print it or not!
						return self.errors > 0 and (self.error_icon .. self.errors .. " ")
					end,
					hl = { fg = "red" },
				},
				{
					provider = function(self)
						return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
					end,
					hl = { fg = "yellow" },
				},
				{
					provider = function(self)
						return self.info > 0 and (self.info_icon .. self.info .. " ")
					end,
					hl = { fg = "blue" },
				},
				{
					provider = function(self)
						return self.hints > 0 and (self.hint_icon .. self.hints)
					end,
					hl = { fg = "cyan" },
				},
			}

			local Git = {
				condition = conditions.is_git_repo,
				init = function(self)
					self.status_dict = vim.b.gitsigns_status_dict
					self.has_changes = self.status_dict.added ~= 0
						or self.status_dict.removed ~= 0
						or self.status_dict.changed ~= 0
				end,
				hl = { fg = "peach" },
				{
					-- git branch name
					provider = function(self)
						return self.status_dict.head
					end,
					hl = { bold = true },
				},
				-- You could handle delimiters, icons and counts similar to Diagnostics
				{
					condition = function(self)
						return self.has_changes
					end,
					provider = "(",
				},
				{
					provider = function(self)
						local count = self.status_dict.added or 0
						return count > 0 and ("+" .. count)
					end,
					hl = { fg = "green" },
				},
				{
					provider = function(self)
						local count = self.status_dict.removed or 0
						return count > 0 and ("-" .. count)
					end,
					hl = { fg = "red" },
				},
				{
					provider = function(self)
						local count = self.status_dict.changed or 0
						return count > 0 and ("~" .. count)
					end,
					hl = { fg = "yellow" },
				},
				{
					condition = function(self)
						return self.has_changes
					end,
					provider = ")",
				},
			}

			local HelpFileName = {
				condition = function()
					return vim.bo.filetype == "help"
				end,
				provider = function()
					local filename = vim.api.nvim_buf_get_name(0)
					return vim.fn.fnamemodify(filename, ":t")
				end,
				hl = { fg = utils.get_highlight("Directory").fg },
			}

			local SearchCount = {
				condition = function()
					return vim.v.hlsearch ~= 0 -- and vim.o.cmdheight == 0
				end,
				init = function(self)
					local ok, search = pcall(vim.fn.searchcount)
					if ok and search.total then
						self.search = search
					end
				end,
				provider = function(self)
					local search = self.search
					return string.format("[%d/%d]", search.current, math.min(search.total, search.maxcount))
				end,
				hl = { fg = "subtext0" },
				{ provider = " " },
			}

			local MacroRec = {
				{
					provider = " ",
					condition = function()
						return vim.fn.reg_recording() ~= ""
					end,
				},
				{
					condition = function()
						return vim.fn.reg_recording() ~= "" -- and vim.o.cmdheight == 0
					end,
					provider = " ",
					hl = { fg = "red", bold = true },
					utils.surround({ "[", "]" }, nil, {
						provider = function()
							return vim.fn.reg_recording()
						end,
						hl = { fg = "green", bold = true },
					}),
					update = {
						"RecordingEnter",
						"RecordingLeave",
					},
				},
			}

			local Scrollbar = {
				static = {
					-- sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
					sbar = { "🭶", "🭷", "🭸", "🭹", "🭺", "🭻" },
				},
				init = function(self)
					self.curr_line = vim.api.nvim_win_get_cursor(0)[1]
					self.lines = vim.api.nvim_buf_line_count(0)
				end,
				provider = function(self)
					local i = math.floor((self.curr_line - 1) / self.lines * #self.sbar) + 1
					return string.rep(self.sbar[i], 2)
				end,
				hl = function(self)
					if self.curr_line == self.lines or self.curr_line == 1 then
						return { fg = "red", bg = "base" }
					end

					return { fg = "mauve", bg = "base" }
				end,
			}

			local ALIGN = { provider = "%=" }
			local SPACE = { provider = "  " }

			local StatusLine = {
				ViMode,
				MacroRec,
				SPACE,
				FileNameBlock,
				SPACE,
				HelpFileName,
				Git,
				SPACE,
				Diagnostics,
				ALIGN,
				LSPActive,
				SPACE,
				FileType,
				SPACE,
				SearchCount,
				WordCount,
				Scrollbar,
				static = {
					mode_names = {
						n = "H",
						no = "H?",
						nov = "H?",
						noV = "H?",
						["no\22"] = "H?",
						niI = "Hi",
						niR = "Hr",
						niV = "Hv",
						nt = "Ht",
						v = "V",
						vs = "Vs",
						V = "V_",
						Vs = "Vs",
						["\22"] = "^V",
						["\22s"] = "^V",
						s = "S",
						S = "S_",
						["\19"] = "^S",
						i = "I",
						ic = "Ic",
						ix = "Ix",
						R = "R",
						Rc = "Rc",
						Rx = "Rx",
						Rv = "Rv",
						Rvc = "Rv",
						Rvx = "Rv",
						c = "C",
						cv = "Ex",
						r = "...",
						rm = "M",
						["r?"] = "?",
						["!"] = "!",
						t = "T",
					},
					mode_colors = {
						n = "mauve",
						i = "sky",
						v = "green",
						V = "green",
						["\22"] = "cyan",
						c = "peach",
						s = "yellow",
						S = "yellow",
						["\19"] = "mauve",
						R = "red",
						r = "red",
						["!"] = "red",
						t = "pink",
					},
					mode_color = function(self)
						local mode = conditions.is_active() and vim.fn.mode() or "n"
						return self.mode_colors_map[mode]
					end,
				},
			}

			heirline.setup({
				statusline = StatusLine,
				opts = {
					colors = get_colors(),
				},
			})
		end,
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
		lazy = false,
		opts = {
			options = {
				use_as_default_explorer = true,
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
		lazy = false,
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
		opts = {},
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"tpope/vim-fugitive",
		lazy = false,
	},
}
