local M = {}

local function set_highlights_lackluster(recording)
	local lackluster = require("lackluster")

	local bg = lackluster.color_special.statusline
	local fg = recording and lackluster.color.red or lackluster.color.gray7

	--  xxx guifg=#aaaaaa guibg=#242424
	vim.api.nvim_set_hl(0, "StatusLine", { fg = fg, bg = bg })

	vim.api.nvim_set_hl(0, "Ruler", {
		fg = lackluster.color.gray7,
		bg = bg,
	})

	vim.api.nvim_set_hl(0, "StatusLsp", {
		fg = lackluster.color.green,
		bg = bg,
	})

	vim.api.nvim_set_hl(0, "StatusFt", {
		fg = lackluster.color.orange,
		bg = bg,
	})

	vim.api.nvim_set_hl(0, "StatusHead", {
		fg = lackluster.color.yellow,
		bg = bg,
	})
end

local function set_highlights_everforest(recording)
	local config = vim.fn["everforest#get_configuration"]()
	local palette = vim.fn["everforest#get_palette"](config.background, config.colors_override)
	local set_hl = vim.fn["everforest#highlight"]

	local bg = palette.bg1
	local fg = recording and palette.red or palette.fg

	set_hl("StatusLine", fg, bg)
	set_hl("Ruler", palette.statusline3, bg)
	set_hl("StatusLsp", palette.statusline3, bg)
	set_hl("StatusFt", palette.statusline2, bg)
	set_hl("StatusHead", palette.statusline1, bg)
end

local augroup = vim.api.nvim_create_augroup("StatusLine", { clear = true })

vim.api.nvim_create_autocmd({ "ColorScheme", "RecordingLeave" }, {
	pattern = "*",
	group = augroup,
	callback = function()
		set_highlights_everforest(false)
	end,
})

vim.api.nvim_create_autocmd({ "RecordingEnter" }, {
	pattern = "*",
	group = augroup,
	callback = function()
		set_highlights_everforest(true)
	end,
})

local function finish()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	local names = vim.tbl_map(function(value)
		return value.name
	end, clients)

	return "%(%#StatusLsp#" .. vim.fn.join(names, ", ") .. "%* %#StatusFt#%y%* %l,%c %)"
end

local function git()
	return " %#StatusHead#%{FugitiveStatusline()} "
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

set_highlights_everforest(false)

return M
