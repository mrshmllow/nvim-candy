-- I just like having it seperated by ft even if its not heavy
vim.g.rustaceanvim = {
	tools = {},
	server = {
		settings = {
			["rust-analyzer"] = {},
		},
	},
	dap = {},
}

vim.keymap.set("n", "gra", function()
	vim.cmd.RustLsp("codeAction")
end, { buffer = true, silent = true })

vim.keymap.set("n", "K", function()
	vim.cmd.RustLsp({ "hover", "actions" })
end, { buffer = true, silent = true })
