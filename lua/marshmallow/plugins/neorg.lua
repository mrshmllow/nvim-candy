return {
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- "folke/zen-mode.nvim"
		},
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/notes",
							},
						},
					},
					["core.clipboard.code-blocks"] = {},
					["core.export"] = {},
					["core.export.markdown"] = {
						config = {
							extensions = "all",
						},
					},
					["core.completion"] = {
						config = { engine = "nvim-cmp" },
					},
					["core.summary"] = {},
					-- ["core.presenter"] = {
					-- 	config = { zen_mode = "zen-mode" },
					-- },
				},
			})
		end,
	},
}
