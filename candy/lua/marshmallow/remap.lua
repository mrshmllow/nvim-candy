require("which-key").setup({})

-- experimental --
vim.keymap.set("n", "0", "^", { noremap = true, silent = true })
vim.keymap.set("n", "^", "0", { noremap = true, silent = true })

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

vim.keymap.set("n", "<leader>/", function()
	local cope = function()
		local items = require("mini.pick").get_picker_items()

		vim.fn.setqflist(vim.tbl_map(function(value)
			local split = vim.split(value, ":")
			local text = table.concat(split, "", 4)

			return {
				filename = split[1],
				lnum = split[2],
				col = split[3],
				text = vim.trim(text),
			}
		end, items))

		vim.cmd.cope()
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

-- Harpoon --
require("lz.n").load({
	"harpoon",
	keys = {
		{
			"<leader>a",
			function()
				require("harpoon"):list():append()
			end,
			mode = "n",
			desc = "Harpoon file",
		},
		{
			"<leader><C-space>",
			function()
				require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
			end,
			mode = "n",
			desc = "Toggle Harpoon",
		},
		unpack(vim.iter(vim.fn.range(1, 5))
			:map(function(i)
				return {
					"<M-" .. i .. ">",
					function()
						require("harpoon"):list():select(i)
					end,
					mode = "n",
					desc = "Switch to file " .. i,
				}
			end)
			:totable()),
	},
	before = function()
		require("harpoon"):setup()
	end,
})

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
	vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
	vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
	vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
end
