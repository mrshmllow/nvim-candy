return {
	filetypes = vim.iter({ ((vim.lsp.config.textlab or {}).filetypes or {}), { "lhaskell" } }):flatten():totable(),
}
