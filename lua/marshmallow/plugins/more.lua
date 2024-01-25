return {
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
