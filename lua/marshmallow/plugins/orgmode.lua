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
			{ "michaelb/sniprun", build = "sh install.sh", dev = true },
			"edluffy/hologram.nvim",
			"jubnzv/mdeval.nvim",
		},
		keys = {
			"<Leader>oa",
			"<Leader>oc",
		},
		ft = { "org" },
    lazy = false,
		config = function()
			require("orgmode").setup_ts_grammar()

			require("orgmode").setup({
				org_agenda_files = { "~/my-orgs/**/*" },
				org_default_notes_file = "~/my-orgs/refile.org",
        org_indent_mode = "noindent",
			})

			require("sniprun").setup({
				selected_interpreters = { "OrgMode_original" },
				display = { "Api" },
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
	{
		"mrshmllow/orgmode-babel.nvim",
		dependencies = {
			"nvim-orgmode/orgmode",
			"nvim-treesitter/nvim-treesitter",
		},
    dev = true,
		cmd = { "OrgExecute", "OrgTangle" },
		opts = {
			langs = { "python", "lua", "mermaid" },
		},
	},
}
