if vim.g.neovide then
	vim.opt.guifont = { "JetBrainsMono Nerd Font Mono", ":h14:w-1" }

	vim.g.neovide_input_use_logo = 1

	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0

	vim.g.neovide_hide_mouse_when_typing = true

	vim.g.neovide_cursor_animate_command_line = false

	vim.g.neovide_cursor_animation_length = 0.1

	vim.g.winblend = 30
	vim.g.pumblend = 30

	vim.g.neovide_scale_factor = 1.25

	vim.g.neovide_padding_top = 10
	vim.g.neovide_padding_bottom = 10
	vim.g.neovide_padding_right = 10
	vim.g.neovide_padding_left = 10

	vim.g.neovide_transparency = 0.9

	-- TODO: Sort this out
	-- vim.g.neovide_theme = "auto"

	vim.g.neovide_refresh_rate = 240

	-- Is this okay??
	vim.opt.linespace = -2

	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end

	vim.keymap.set("n", "<C-=>", function()
		change_scale_factor(1.25)
	end)
	vim.keymap.set("n", "<C-->", function()
		change_scale_factor(1 / 1.25)
	end)

	vim.keymap.set("v", "<D-c>", '"+y') -- Copy
	vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
	vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
	vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
end

vim.api.nvim_create_user_command("Trans", function()
	if vim.g.neovide_transparency ~= 1 then
		vim.g.neovide_transparency = 1
	else
		vim.g.neovide_transparency = 0.9
	end
end, {})
