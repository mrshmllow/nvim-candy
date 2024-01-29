return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"b0o/schemastore.nvim",
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
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					local bufnr = ev.buf


					-- if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint.enable ~= nil then
					if vim.lsp.inlay_hint.enable ~= nil then
						vim.lsp.inlay_hint.enable(bufnr, true)
					end

					if client.server_capabilities.definitionProvider then
						vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
					end

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
					vim.keymap.set("n", "<leader>r", function()
						require("conform").format()
					end, { noremap = true, silent = true, buffer = bufnr, desc = "Format document" })
				end,
			})

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						format = {
							-- Use stylua
							enable = false,
						},
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
			lspconfig.tailwindcss.setup({
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
			lspconfig.cssls.setup({
				cmd = { "css-languageserver", "--stdio" },
			})
			lspconfig.nil_ls.setup({})
			lspconfig.jsonls.setup({
				cmd = { "json-languageserver", "--stdio" },
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})
			lspconfig.yamlls.setup({
				settings = {
					yaml = {
						schemaStore = {
							-- You must disable built-in schemaStore support if you want to use
							-- this plugin and its advanced options like `ignore`.
							enable = false,
						},
						schemas = require("schemastore").yaml.schemas(),
					},
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					-- Use a sub-list to run only the first available formatter
					javascript = { { "prettierd", "prettier" } },
					nix = { "alejandra" },
					toml = { "taplo" },
				},
				format_on_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = "neovim/nvim-lspconfig",
		ft = { "typescript", "typescriptreact" },
		config = function()
			require("typescript-tools").setup({
				settings = {
					-- https://github.com/pmizio/typescript-tools.nvim/blob/master/lua/typescript-tools/protocol/text_document/did_open.lua#L8
					tsserver_file_preferences = {
						includeInlayParameterNameHints = "all",
						includeInlayFunctionParameterTypeHints = true,
						includeInlayEnumMemberValueHints = true,

						includeCompletionsForModuleExports = true,

						quotePreference = "auto",
					},
					tsserver_format_options = {
						allowIncompleteCompletions = false,
						allowRenameOfImportPath = false,
					},
				},
			})
		end,
	},
	-- {
	-- 	"mfussenegger/nvim-jdtls",
	-- 	dependencies = "neovim/nvim-lspconfig",
	-- 	ft = { "java" },
	-- 	config = function()
	-- 		local config = {
	-- 			-- https://github.com/NixOS/nixpkgs/issues/232822#issuecomment-1564243667
	-- 			cmd = { "jdt-language-server", "-data", "$XDG_CACHE_HOME/jdtls/$PWD" },
	-- 			root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
	-- 		}

	-- 		require("jdtls").start_or_attach(config)
	-- 	end,
	-- },
	{
		"mrcjkb/rustaceanvim",
		version = "^3",
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				tools = {},
				server = {
					settings = {
						["rust-analyzer"] = {},
					},
				},
				dap = {},
			}
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
