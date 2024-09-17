local M = {}

local function set_highlights(recording)
	local palette = require("kanagawa.colors").setup().theme

	local bg = recording and palette.diff.delete or palette.ui.bg_m2
	local fg = recording and palette.vcs.removed or palette.ui.fg_dim

	vim.api.nvim_set_hl(0, "StatusLine", { fg = fg, bg = bg })

	vim.api.nvim_set_hl(0, "Ruler", {
		fg = palette.syn.keyword,
		bg = bg,
	})

	vim.api.nvim_set_hl(0, "StatusLsp", {
		fg = palette.syn.constant,
		bg = bg,
	})

	vim.api.nvim_set_hl(0, "StatusFt", {
		fg = palette.syn.type,
		bg = bg,
	})

	vim.api.nvim_set_hl(0, "StatusAdd", {
		fg = palette.vcs.added,
		bg = bg,
	})

	vim.api.nvim_set_hl(0, "StatusChanged", {
		fg = palette.vcs.changed,
		bg = bg,
	})

	vim.api.nvim_set_hl(0, "StatusRemoved", {
		fg = palette.vcs.removed,
		bg = bg,
	})

	vim.api.nvim_set_hl(0, "StatusHead", {
		fg = palette.syn.identifier,
		bg = bg,
	})
end

local augroup = vim.api.nvim_create_augroup("StatusLine", { clear = true })

vim.api.nvim_create_autocmd({ "ColorScheme", "RecordingLeave" }, {
	pattern = "*",
	group = augroup,
	callback = function()
		set_highlights(false)
	end,
})

vim.api.nvim_create_autocmd({ "RecordingEnter" }, {
	pattern = "*",
	group = augroup,
	callback = function()
		set_highlights(true)
	end,
})

local function get_scrollbar()
	local bars = { "🭶", "🭷", "🭸", "🭹", "🭺", "🭻" }
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local lines = vim.api.nvim_buf_line_count(0)

	local i = math.floor((current_line - 1) / lines * #bars) + 1

	return "%p%% %#Ruler#" .. string.rep(bars[i], 2)
end

local function finish()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	local names = vim.tbl_map(function(value)
		return value.name
	end, clients)

	return "%(%#StatusLsp#" .. vim.fn.join(names, ", ") .. "%* %#StatusFt#%y%* %l,%c " .. get_scrollbar() .. "%)"
end

local function git()
	local status = vim.b.gitsigns_status_dict
	if status == nil then
		return " "
	end

	local has_changes = status.added ~= 0 or status.removed ~= 0 or status.changed ~= 0
	local added_count = status.added or 0
	local removed_count = status.removed or 0
	local changed_count = status.removed or 0

	local added = added_count > 0 and ("%#StatusAdd#+" .. added_count .. "%*") or ""
	local removed = removed_count > 0 and ("%#StatusRemoved#-" .. removed_count .. "%*") or ""
	local changed = changed_count > 0 and ("%#StatusChanged#~" .. changed_count .. "%*") or ""
	local changes = "(" .. added .. removed .. changed .. "%#StatusHead#)%*"

	return " %#StatusHead#" .. status.head .. (has_changes and changes or "") .. "%*"
end

local function first()
	return "%(%f%m%h%r" .. git() .. "%)"
end

local function center()
	local reg = vim.fn.reg_recording()
	if reg ~= "" then
		return "%(Recording to @" .. reg .. "%)%="
	end

	return ""
end

function M.statusline()
	return first() .. "%=" .. center() .. finish()
end

return M
