require("fidget").setup({})

local group = vim.api.nvim_create_augroup("marsh-lsp", {})

vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	callback = function(ev)
		local bufnr = ev.buf

		vim.lsp.inlay_hint.enable(true, {
			bufnr = bufnr,
		})

		local opts = { noremap = true, silent = true }
		vim.keymap.set("n", "E", vim.diagnostic.open_float, opts)
		vim.keymap.set(
			"n",
			"<space>q",
			vim.diagnostic.setloclist,
			{ noremap = true, silent = true, desc = "Add diagnostics to list" }
		)

		local bufopts = { noremap = true, silent = true, buffer = bufnr }

		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	end,
})

vim.lsp.config("tailwindcss", {
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

-- Boilerplate from https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
vim.lsp.config("lua_ls", {
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			return
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- Depending on the usage, you might want to add additional paths here.
					-- vim.env.LUV .. "lib/lua/5.1/",
					-- "${3rd}/busted/library",
				},
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
				-- library = vim.api.nvim_get_runtime_file("", true),
			},
		})
	end,
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

vim.lsp.enable({
	"tailwindcss",
	"astro",
	"nil_ls",
	"gopls",
	"golangci_lint_ls",
	"pyright",
	"tinymist",
})
