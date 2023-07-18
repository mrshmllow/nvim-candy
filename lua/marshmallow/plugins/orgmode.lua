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
			{ "edluffy/hologram.nvim", cond = not vim.g.neovide },
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
				org_agenda_files = { "~/org/**/*" },
				org_default_notes_file = "~/my-orgs/refile.org",
				org_indent_mode = "noindent",
				org_capture_templates = {
					t = {
						description = "Task",
						template = "* TODO %?\n  %u",
						target = "~/org/refile.org",
					},
					n = {
						description = "Quick Note",
						template = "* Note\n%U\n\n%?",
						target = "~/org/t3_23_refile.org",
					},
				},
			})

			require("org-bullets").setup({})
			-- require("headlines").setup()

			if not vim.g.neovide then
				require("hologram").setup({
					auto_display = true,
				})
			end

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
