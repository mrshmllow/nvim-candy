vim.api.nvim_create_user_command("Detach", function()
	local tuis = vim.api.nvim_list_uis()

	for _, value in ipairs(tuis) do
		vim.fn.chanclose(value.chan)
	end
end, {})

local ns = vim.api.nvim_create_namespace("marker")

local colors = { "yellow", "blue", "red" }
local color_map = {
	yellow = "@text.todo",
	blue = "@text.note",
	red = "@text.danger",
}

vim.api.nvim_create_user_command("Mark", function(res)
	local begin_col = vim.api.nvim_buf_get_mark(0, "<")[2]
	local end_col = vim.api.nvim_buf_get_mark(0, ">")[2]
	local line1 = res.line1
	local line2 = res.line2

	if res.range == 0 then
		line1, begin_col = unpack(vim.api.nvim_buf_get_mark(0, "("))
		line2, end_col = unpack(vim.api.nvim_buf_get_mark(0, ")"))
	end

	vim.b.marker_index = vim.b.marker_index or 0

	-- Yellow
	local hi = "Todo"

	if res.args == "clear" then
		vim.api.nvim_buf_clear_namespace(0, ns, line1 - 1, line2)
		return
	end

	if vim.tbl_contains(colors, res.args) then
		hi = color_map[res.args]
	else
		hi = color_map[colors[vim.b.marker_index % #colors + 1]]
		vim.b.marker_index = vim.b.marker_index + 1
	end

	-- Single line highlight
	if line1 == line2 then
		vim.api.nvim_buf_add_highlight(0, ns, hi, line1 - 1, begin_col, end_col + 1)
		return
	end

	for line = line1, line2 do
		-- At beginning
		if line == line1 then
			vim.api.nvim_buf_add_highlight(0, ns, hi, line - 1, begin_col, -1)
			goto continue
		end

		-- At end
		if line == line2 then
			vim.api.nvim_buf_add_highlight(0, ns, hi, line - 1, 0, end_col)
			goto continue
		end

		vim.api.nvim_buf_add_highlight(0, ns, hi, line - 1, 0, -1)

		::continue::
	end
end, {
	range = true,
	nargs = "?",
	complete = function()
		return vim.list_extend({ "clear" }, colors)
	end,
})

vim.api.nvim_create_user_command("MarkWipe", function()
	vim.api.nvim_buf_clear_namespace(0, ns, -1, -1)
end, {})
