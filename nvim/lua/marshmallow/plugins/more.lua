return {
	{
		"glacambre/firenvim",
		cond = not not vim.g.started_by_firenvim,
		build = function()
			require("lazy").load({ plugins = "firenvim", wait = true })
			vim.fn["firenvim#install"](0)
		end,
	},
	{
		"declancm/cinnamon.nvim",
		opts = {
			default_delay = 0.1,
		},
		event = "VeryLazy",
    dev = true,
		cond = not vim.g.neovide,
	},
}
