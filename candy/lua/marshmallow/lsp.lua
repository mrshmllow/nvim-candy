vim.g.rustaceanvim = {
	tools = {},
	server = {
		settings = {
			["rust-analyzer"] = {
				diagnostics = {
					enable = true,
					disabled = { "proc-macro-disabled" },
					enableExperimental = true,
				},

				procMacro = {
					ignored = {
						leptos_macro = {
							"component",
							"server",
						},
					},
				},
				cargo = {
					features = "all", -- Run against all crate features
				},
			},
		},
	},
	dap = {},
}

require("fidget").setup({})

local group = vim.api.nvim_create_augroup("marsh-lsp", {})

vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	callback = function(ev)
		local bufnr = ev.buf

		vim.lsp.inlay_hint.enable(true, {
			bufnr = bufnr,
		})
	end,
})

local lsp_configs = {}
local disabled = {
	"rust_analyzer",
	"ts_ls",
	"volar", -- message was annoying, depcrecated
	"gitlab_duo",
}

for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
	local server_name = vim.fn.fnamemodify(f, ":t:r")

	for _, server in ipairs(disabled) do
		if server_name == server then
			goto skip
		end
	end

	table.insert(lsp_configs, server_name)

	::skip::
end

vim.lsp.enable(lsp_configs)
