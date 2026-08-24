local config_path = (vim.env.XDG_CONFIG_HOME == nil and vim.env.XDG_CONFIG_HOME or vim.env.HOME .. "/.config")
	.. "/base16-theme.json"
local file = io.open(config_path, "r")

if not file then
	vim.warn.error("no base16-theme.json file!")
	return
end

local content = file:read("*a")
file:close()

local tbl = vim.json.decode(content)

tbl.author = nil
tbl.scheme = nil
tbl.slug = nil

local palette = vim.tbl_map(function(value)
	if vim.startswith(value, "#") then
		return value
	end

	return "#" .. value
end, tbl)

require("mini.base16").setup({
	palette = palette,
	use_cterm = true,
	plugins = {
		default = true,
	},
})
