return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
			"petertriho/cmp-git",

			{
				"zbirenbaum/copilot.lua",
				config = function()
					require("copilot").setup({
						filetypes = {
							sh = function()
								if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
									return false
								end
								return true
							end,
							norg = false,
						},
						event = { "InsertEnter", "LspAttach" },
						fix_pairs = true,
					})
				end,
			},
			"zbirenbaum/copilot-cmp",
		},
		config = function()
			vim.g.completeopt = "menu,menuone,noselect"
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					-- documentation = cmp.config.window.bordered(),
					completion = {
						-- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						col_offset = -3,
						side_padding = 0,
						scrolloff = 2,
					},
				},
				view = {
					entries = { name = "custom", selection_order = "near_cursor" },
				},
				experimental = {
					ghost_text = true,
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						require("copilot_cmp.comparators").prioritize,

						cmp.config.compare.offset,
						-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.locality,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = require("lspkind").cmp_format({
							mode = "symbol",
							maxwidth = 50,
							symbol_map = {
								Copilot = "",
							},
						})(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "

						return kind
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "neorg", group_index = 2 },
					{ name = "nvim_lsp", group_index = 2 },
					{ name = "copilot", group_index = 2 },
					{ name = "git", group_index = 2 },
					{ name = "luasnip", group_index = 2 },
				}, {
					{ name = "buffer" },
				}),
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			require("copilot_cmp").setup()
			require("cmp_git").setup()
		end,
	},
}
