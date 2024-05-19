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
