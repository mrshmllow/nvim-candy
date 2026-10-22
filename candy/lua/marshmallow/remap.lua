local GROUP = vim.api.nvim_create_augroup("marsh-keymap", {})

local miniclue = require("mini.clue")
miniclue.setup({
	triggers = {
		-- Leader triggers
		{ mode = "n", keys = "<Leader>" },
		{ mode = "x", keys = "<Leader>" },

		-- Built-in completion
		{ mode = "i", keys = "<C-x>" },

		-- `g` key
		{ mode = "n", keys = "g" },
		{ mode = "x", keys = "g" },

		-- Marks
		{ mode = "n", keys = "'" },
		{ mode = "n", keys = "`" },
		{ mode = "x", keys = "'" },
		{ mode = "x", keys = "`" },

		-- Registers
		{ mode = "n", keys = '"' },
		{ mode = "x", keys = '"' },
		{ mode = "i", keys = "<C-r>" },
		{ mode = "c", keys = "<C-r>" },

		-- Window commands
		{ mode = "n", keys = "<C-w>" },

		-- `z` key
		{ mode = "n", keys = "z" },
		{ mode = "x", keys = "z" },

		-- mini surround
		{ mode = "n", keys = "s" },
		{ mode = "x", keys = "s" },

		-- mini bracketed
		{ mode = "n", keys = "]" },
		{ mode = "n", keys = "[" },
	},

	clues = {
		-- Enhance this by adding descriptions for <Leader> mapping groups
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
	},
})

-- mini.surround
-- fix s key deleting characters
vim.keymap.set({ "n", "x" }, "s", "<Nop>")

-- nvim-spider
require("lz.n").load({
	"nvim-spider",
	keys = {
		{ "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" }, desc = "Spider-w" },
		{ "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" }, desc = "Spider-e" },
		{ "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" }, desc = "Spider-b" },
	},
	after = function()
		require("spider").setup({
			skipInsignificantPunctuation = false,
			subwordMovement = true,
			customPatterns = {},
		})
	end,
})

-- quick save

vim.keymap.set("n", "<C-s>", ":w<cr>", { silent = true })

-- Window movement --
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-J>", "<C-W><C-J>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", { noremap = true, silent = true })

-- Wrapped line movement --
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Terminal --

-- Leave normal mode
vim.keymap.set("t", "<C-w>n", "<C-\\><C-n><C-w>h", { silent = true })
vim.keymap.set("t", "<C-w><C-n>", "<C-\\><C-n><C-w>h", { silent = true })

-- Grep / Pick --
vim.keymap.set("n", "<leader>f", require("mini.pick").builtin.files, { desc = "Pick (root dir)" })
vim.keymap.set("n", "<leader>g", require("mini.pick").builtin.resume, { desc = "Resume Pick" })

vim.keymap.set("n", "<leader>/", function()
	local cope = function()
		local query = require("mini.pick").get_picker_query()

		vim.cmd("vimgrep " .. table.concat(query))

		return true
	end
	local buffer_mappings = { wipeout = { char = "<C-q>", func = cope } }
	require("mini.pick").builtin.grep_live({}, { mappings = buffer_mappings })
end, { desc = "Grep (root dir)" })

vim.keymap.set("n", "<leader><leader>", function()
	local wipeout_current = function()
		vim.api.nvim_buf_delete(require("mini.pick").get_picker_matches().current.bufnr, {})
	end
	local buffer_mappings = { wipeout = { char = "<C-d>", func = wipeout_current } }
	require("mini.pick").builtin.buffers({ include_current = false }, { mappings = buffer_mappings })
end, { desc = "Switch Buffer" })

vim.keymap.set("n", "<leader>s", function()
	require("mini.jump2d").start()
end, { desc = "Jump2d" })

-- Files --
vim.keymap.set("n", "-", function()
	require("mini.files").open(vim.api.nvim_buf_get_name(0))
end, { desc = "Open Files" })

-- Gui --
if vim.g.neovide then
	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end

	vim.keymap.set("n", "<C-=>", function()
		change_scale_factor(1.25)
	end)
	vim.keymap.set("n", "<C-->", function()
		change_scale_factor(1 / 1.25)
	end)

	vim.keymap.set("v", "<D-c>", '"+y') -- Copy
	vim.keymap.set({ "n", "v" }, "<D-v>", '"+P') -- Paste
	vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
end

-- Completion --

-- <CR> In completion
local keycode = vim.keycode or function(x)
	return vim.api.nvim_replace_termcodes(x, true, true, true)
end

local keys = {
	-- Accept
	["cr"] = keycode("<CR>"),
	-- Enter the selected option
	["ctrl-y"] = keycode("<C-y>"),
}

_G.cr_action = function()
	-- If there is selected item in popup, accept it with <C-y>
	if vim.fn.complete_info()["selected"] ~= -1 then
		return keycode("<CR>")
	end

	-- Fall back to plain `<CR>`. You might want to customize according
	-- to other plugins. For example if 'mini.pairs' is set up, replace
	-- next line with `return MiniPairs.cr()`
	return "\r"
end

vim.keymap.set("i", "<CR>", "v:lua._G.cr_action()", { expr = true })

-- Lsp --
vim.api.nvim_create_autocmd("LspAttach", {
	group = GROUP,
	callback = function(ev)
		local bufnr = ev.buf

		local opts = { noremap = true, silent = true }
		vim.keymap.set("n", "E", vim.diagnostic.open_float, opts)
		vim.keymap.set(
			"n",
			"<space>q",
			vim.diagnostic.setloclist,
			{ noremap = true, silent = true, desc = "Add diagnostics to list" }
		)

		local bufopts = { noremap = true, silent = true, buffer = bufnr }

		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	end,
})
