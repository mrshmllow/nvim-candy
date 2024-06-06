-- Conform keymaps set in `lsp`

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Use a sub-list to run only the first available formatter
		javascript = { { "prettierd", "prettier" } },
		nix = { "alejandra" },
		toml = { "taplo" },
		sql = { "sql_formatter" },
		["*"] = { "injected" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
	formatters = {
		sql_formatter = {
			cmd = "sql-formatter",
			-- TODO: Find a better way.......
			prepend_args = { "-l", "postgresql" },
		},
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
