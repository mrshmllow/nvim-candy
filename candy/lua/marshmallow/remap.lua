require("which-key").setup({})
-- Other keymaps set in `remap`

vim.keymap.set("n", "<C-s>", ":w<cr>", { silent = true })

-- Window movement --
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-J>", "<C-W><C-J>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", { noremap = true, silent = true })

-- Wrapped line movement --
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Lazygit --
vim.keymap.set({ "n" }, "<leader>tl", function()
	if vim.g.marsh_lazygit_buf == nil then
		vim.cmd.terminal("lazygit")
		vim.cmd.startinsert()
		vim.g.marsh_lazygit_buf = vim.api.nvim_win_get_buf(0)

		vim.api.nvim_create_autocmd({ "BufDelete" }, {
			buffer = vim.g.marsh_lazygit_buf,
			callback = function()
				vim.g.marsh_lazygit_buf = nil
			end,
		})
	else
		vim.api.nvim_set_current_buf(vim.g.marsh_lazygit_buf)
	end
end, {
	desc = "Open Lazygit",
})

-- Terminal --

-- Leave normal mode
vim.keymap.set("t", "<C-w>n", "<C-\\><C-n><C-w>h", { silent = true })
vim.keymap.set("t", "<C-w><C-n>", "<C-\\><C-n><C-w>h", { silent = true })

-- Grep / Pick --
vim.keymap.set("n", "<leader>f", require("mini.pick").builtin.files, { desc = "Pick (root dir)" })

vim.keymap.set("n", "<leader>/", function()
	local cope = function()
		vim.api.nvim_buf_delete(require("mini.pick").get_picker_matches().current.bufnr, {})
	end
	local buffer_mappings = { wipeout = { char = "<C-q>", func = cope } }
	require("mini.pick").builtin.grep_live({}, { mappings = buffer_mappings })
end, { desc = "Grep (root dir)" })

vim.keymap.set("n", "<leader>/", function()
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
