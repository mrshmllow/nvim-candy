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

local ns = vim.api.nvim_create_namespace("marshmallow-mini-files")

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

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferUpdate",
	group = id,
	callback = function(args)
		local data = args.data
		local buf_id = data.buf_id
		local lines = vim.api.nvim_buf_get_lines(data.buf_id, 0, -1, false)

		for line_num in ipairs(lines) do
			local fs_entry = require("mini.files").get_fs_entry(buf_id, line_num)

			if fs_entry == nil then
				goto continue
			end

			local obj = vim.system({ "git", "diff", "--exit-code", "--shortstat", fs_entry.path }, { text = true })
				:wait()

			if obj.code ~= 1 then
				goto continue
			end

			local changes = {}

			if fs_entry.fs_type == "directory" then
				-- first number in the string is the number of files changed
				table.insert(changes, {
					"~" .. string.match(obj.stdout, "%d"),
					"MiniDiffSignChange",
				})
			end

			for value in string.gmatch(obj.stdout, "%d+ %w+%([-+]%)") do
				local number = string.match(value, "%d+")
				local change = string.match(value, "[-+]")

				table.insert(changes, {
					change .. number,
					change == "-" and "MiniDiffSignDelete" or "MiniDiffSignAdd",
				})
			end

			vim.api.nvim_buf_set_extmark(buf_id, ns, line_num - 1, 0, {
				virt_text = changes,
			})

			::continue::
		end
	end,
})
