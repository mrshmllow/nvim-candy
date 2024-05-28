vim.api.nvim_create_user_command("Trans", function()
	if vim.g.neovide_transparency ~= 1 then
		vim.g.neovide_transparency = 1
	else
		vim.g.neovide_transparency = 0.9
	end
end, {})

vim.api.nvim_create_user_command("Z", function(val)
	local obj = vim.system({ "fish", "-c", "z -e " .. val["args"] }, { text = true }):wait()

	if obj.code == 0 then
		return vim.cmd.cd(obj.stdout:sub(1, -2)) -- remove \n
	end

	vim.notify("Error: " .. obj.stderr, vim.log.levels.ERROR)
end, {
	nargs = 1,
})
