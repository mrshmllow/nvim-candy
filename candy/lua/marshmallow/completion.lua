-- Awaiting mini.completion w/ snippet support...
-- require("mini.completion").setup()

if vim.env.CANDY_CHECK == nil then
	-- Disable in check phase
	require("supermaven-nvim").setup({
		disable_inline_completion = true,
		disable_keymaps = true,
		log_level = "off",
	})
end

local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	view = {
		entries = { name = "custom", selection_order = "near_cursor" },
	},

	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "supermaven" },
		{ name = "luasnip" },
		{ name = "async_path" },
	}, {
		{ name = "buffer" },
	}),

	experimental = { ghost_text = true },
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "async_path" },
	}, {
		{ name = "cmdline" },
	}),
})
