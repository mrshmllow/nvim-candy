vim.api.nvim_create_user_command("Detach", function()
	local tuis = vim.api.nvim_list_uis()

	for _, value in ipairs(tuis) do
		vim.fn.chanclose(value.chan)
	end
end, {})
