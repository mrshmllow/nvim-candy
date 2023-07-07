local id = vim.api.nvim_create_augroup("Marshmallow", {
	clear = true,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.mdx",
	group = id,
	callback = function()
		vim.o.filetype = "markdown"
	end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = id,
	callback = function()
		vim.cmd("wincmd =")
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = id,
	callback = function()
		vim.lsp.buf.format({
			async = false,
		})
	end,
})
