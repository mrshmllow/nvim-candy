-- prob a better way to do this
if string.match(vim.uv.os_uname().release, "WSL") ~= nil then
	require("marshmallow.env.wsl")
end

require("marshmallow.env.gui")
