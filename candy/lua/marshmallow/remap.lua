require("which-key").setup({})

-- experimental --
vim.keymap.set("n", "0", "^", { noremap = true, silent = true })
vim.keymap.set("n", "^", "0", { noremap = true, silent = true })

-- nvim-spider
require("spider").setup({
	skipInsignificantPunctuation = false,
	subwordMovement = true,
	customPatterns = {},
})
vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })

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
local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>a", function()
	harpoon:list():append()
end, { desc = "Harpoon file" })
vim.keymap.set("n", "<leader><C-space>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Toggle Harpoon" })
for i = 1, 5 do
	vim.keymap.set("n", "<M-" .. i .. ">", function()
		harpoon:list():select(i)
	end, { desc = "Switch to file " .. i })
end

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
