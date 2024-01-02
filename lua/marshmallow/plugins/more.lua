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
		"mrshmllow/open-handlers.nvim",
		cond = vim.ui.open ~= nil,
		lazy = false,
		config = function()
			local oh = require("open-handlers")

			oh.setup({
				handlers = {
					oh.issue,
					oh.commit,
					oh.native,
				},
			})
		end,
	},
}
