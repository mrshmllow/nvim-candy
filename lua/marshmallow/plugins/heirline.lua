return {
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
}
