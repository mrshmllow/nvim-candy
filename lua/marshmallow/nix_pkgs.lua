local M = {}

local get_cmd = function(package)
	return { "nix", "build", "--no-link", "--print-out-paths", "nixpkgs#" .. package }
end

local custom_error = function(obj)
	error("Something went wrong... " .. vim.inspect(obj))
	return obj
end

---Get path of a nix package.
---Returns string or |vim.SystemObj| on error.
---@param package string
---@return string|vim.SystemObj
function M.get_sync(package)
	local obj = vim.system(get_cmd(package), { text = true }):wait()

	if obj.code ~= 0 then
		return custom_error(obj)
	end

	local str = obj.stdout:gsub("[\n\r]", "")
	return str
end

---@async
---Asynchronously the path of a nix package
---Passes string or |vim.SystemObj| on error.
---@param package string
---@param on_complete function(path: string|vim.SystemObj)
function M.get(package, on_complete)
	local on_exit = function(obj)
		if obj.code ~= 0 then
			return custom_error(obj)
		end

		vim.schedule(function()
			local str = obj.stdout:gsub("[\n\r]", "")
			on_complete(str)
			vim.cmd("LspStart")
		end)
	end

	vim.system(get_cmd(package), { text = true }, on_exit)
end

return M
