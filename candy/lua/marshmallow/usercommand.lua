vim.api.nvim_create_user_command("Trans", function()
	if vim.g.neovide_transparency ~= 1 then
		vim.g.neovide_transparency = 1
	else
		vim.g.neovide_transparency = 0.9
	end
end, {})
