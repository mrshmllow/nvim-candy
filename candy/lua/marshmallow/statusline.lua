local M = {}

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

return M
