return {
	{
		"dhruvasagar/vim-table-mode",
    cmd = { "TableModeEnable", "TableModeDisable", "Tableize" },
	},
	{
		"nvim-orgmode/orgmode",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"akinsho/org-bullets.nvim",
			"lukas-reineke/headlines.nvim",
			{ "michaelb/sniprun", build = "sh install.sh" },
			"edluffy/hologram.nvim",
		},
		lazy = false,
		ft = { "org" },
		config = function()
			require("orgmode").setup_ts_grammar()

			require("orgmode").setup({
				org_agenda_files = { "~/my-orgs/**/*" },
				org_default_notes_file = "~/my-orgs/refile.org",
			})

			require("sniprun").setup({
				selected_interpreters = { "OrgMode_original" },
			})

			require("org-bullets").setup({})
			-- require("headlines").setup()

			require("hologram").setup({
				auto_display = true,
			})

			vim.opt.conceallevel = 2
			vim.opt.concealcursor = "nc"
		end,
	},
}
