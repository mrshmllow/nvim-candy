local lspconfig = require("lspconfig")
local group = vim.api.nvim_create_augroup("marsh-lsp", {})

vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local bufnr = ev.buf

		vim.lsp.inlay_hint.enable(true, {
			bufnr = bufnr,
		})

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

lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			format = {
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
					{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
					{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
				},
			},
		},
	},
})

lspconfig.astro.setup({})

require("typescript-tools").setup({
	cmd = { "typescript-language-server", "--stdio" },
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
