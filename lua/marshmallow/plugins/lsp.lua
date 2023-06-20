return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		dependencies = {
			"jose-elias-alvarez/typescript.nvim",
		},
		config = function()
			vim.diagnostic.config({
				virtual_text = false,
				signs = false,
				update_in_insert = false,
				severity_sort = true,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					local opts = { noremap = true, silent = true }
					vim.keymap.set("n", "E", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
					vim.keymap.set(
						"n",
						"<space>q",
						vim.diagnostic.setloclist,
						{ noremap = true, silent = true, desc = "Add diagnostics to list" }
					)

					local bufopts = { noremap = true, silent = true, buffer = bufnr }

					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
					vim.keymap.set("n", "cd", vim.lsp.buf.rename, bufopts)
					vim.keymap.set(
						{ "n", "v" },
						"ga",
						vim.lsp.buf.code_action,
						{ noremap = true, silent = true, buffer = bufnr, desc = "Code Actions" }
					)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
					vim.keymap.set("n", "<space>o", function()
						vim.lsp.buf.format({ async = true })
					end, { noremap = true, silent = true, buffer = bufnr, desc = "Format document" })
				end,
			})

			local lspconfig = require("lspconfig")
			lspconfig.rust_analyzer.setup({})
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
						diagnostics = { globals = { "vim" } },
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})
			require("lspconfig").tailwindcss.setup({
				settings = {
					tailwindCSS = {
						experimental = {
							classRegex = {
								{
									"cva\\(([^)]*)\\)",
									"[\"'`]([^\"'`]*).*?[\"'`]",
								},
							},
						},
					},
				},
			})
			lspconfig.pyright.setup({})
			lspconfig.clangd.setup({})
			lspconfig.cssls.setup({})
			lspconfig.nil_ls.setup({})
			require("typescript").setup({
				server = {
					settings = {
						settings = {
							typescript = {
								format = {
									indentSize = vim.o.shiftwidth,
									convertTabsToSpaces = vim.o.expandtab,
									tabSize = vim.o.tabstop,
								},
							},
							javascript = {
								format = {
									indentSize = vim.o.shiftwidth,
									convertTabsToSpaces = vim.o.expandtab,
									tabSize = vim.o.tabstop,
								},
							},
							completions = {
								completeFunctionCalls = true,
							},
						},
					},
					on_attach = function(_, bufnr)
						vim.keymap.set(
							"n",
							"<leader>co",
							"<cmd>TypescriptOrganizeImports<CR>",
							{ buffer = bufnr, desc = "Organize Imports" }
						)
						vim.keymap.set(
							"n",
							"<leader>cR",
							"<cmd>TypescriptRenameFile<CR>",
							{ desc = "Rename File", buffer = bufnr }
						)
						vim.keymap.set(
							"n",
							"gS",
							"<cmd>TypescriptGoToSourceDefinition<CR>",
							{ buffer = bufnr, desc = "Goto Source Definition" }
						)
					end,
				},
			})
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"ThePrimeagen/refactoring.nvim",
			"lewis6991/gitsigns.nvim",
			"jose-elias-alvarez/typescript.nvim",
		},
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.code_actions.refactoring,
					null_ls.builtins.formatting.taplo,
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.stylua.with({
						extra_args = function(params)
							local extra = {}

							if params.lsp_params.options.tabSize then
								table.insert(extra, {
									"--indent-width",
									params.lsp_params.options.tabSize,
								})
							end

							if params.lsp_params.options.insertSpaces then
								table.insert(extra, {
									"--indent-type",
									"Spaces",
								})
							end

							return extra
						end,
					}),
					null_ls.builtins.code_actions.gitsigns,
					require("typescript.extensions.null-ls.code-actions"),
				},
			})
		end,
	},
	{
		"j-hui/fidget.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		event = { "BufReadPre", "BufNewFile" },
		opts = true,
		branch = "legacy",
	},
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		event = { "BufReadPre", "BufNewFile" },
		opts = true,
	},
}
