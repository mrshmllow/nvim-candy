local id = vim.api.nvim_create_augroup("marshmallow", {
	clear = true,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = id,
	callback = function()
		vim.cmd("wincmd =")
	end,
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
	group = id,
	pattern = "*",
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})
