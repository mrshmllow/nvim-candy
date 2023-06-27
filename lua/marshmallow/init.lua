local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup("marshmallow.plugins", {
	change_detection = {
		notify = false,
	},
})

require("marshmallow.defaults")
require("marshmallow.remap")
require("marshmallow.au")
require("marshmallow.commands")
require("marshmallow.neovide")
