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

for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
	local server_name = vim.fn.fnamemodify(f, ":t:r")
	table.insert(lsp_configs, server_name)
end

vim.lsp.enable(lsp_configs)
