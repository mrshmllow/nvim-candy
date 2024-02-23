require("mini.files").setup({
	options = {
		use_as_default_explorer = true,
		permanant_delete = false,
	},
	windows = {
		preview = true,
	},
})

local id = vim.api.nvim_create_augroup("marshmallow-mini-files", {
	clear = true,
})

local show_dotfiles = true

local filter_show = function()
	return true
end

local filter_hide = function(fs_entry)
	return not vim.startswith(fs_entry.name, ".")
end

local toggle_dotfiles = function()
	show_dotfiles = not show_dotfiles
	local new_filter = show_dotfiles and filter_show or filter_hide
	require("mini.files").refresh({ content = { filter = new_filter } })
end

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	group = id,
	callback = function(args)
		local buf_id = args.data.buf_id
		vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle dotfiles" })
	end,
})
