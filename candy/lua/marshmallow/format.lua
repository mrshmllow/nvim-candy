require("lz.n").load({
	"conform.nvim",
	event = "FileType",
	after = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- Use a sub-list to run only the first available formatter
				javascript = { "prettier" },
				nix = { "nixfmt" },
				toml = { "taplo" },
				sql = { "sql_formatter" },
				python = { "black" },
				["*"] = { "injected" },
			},
			default_format_opts = { lsp_format = "prefer" },
			format_on_save = { timeout_ms = 500 },
			formatters = {
				sql_formatter = {
					cmd = "sql-formatter",
					-- TODO: Find a better way.......
					prepend_args = { "-l", "postgresql" },
				},
			},
		})
	end,
})
