if vim.g.neovide then
	-- vim.o.guifont = "JetBrains Mono Nerd Font Mono:h14"
	-- vim.o.guifont = "Vulf Mono:h14"
	vim.o.guifont = "CaskaydiaCove Nerd Font Mono:h14"

  vim.g.neovide_input_use_logo = 1

	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0

	vim.g.neovide_hide_mouse_when_typing = true

  vim.g.neovide_cursor_animate_command_line = false

	vim.g.neovide_cursor_animation_length = 0.1

	vim.g.winblend = 30
	vim.g.pumblend = 30

	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end

	vim.keymap.set("n", "<C-=>", function()
		change_scale_factor(1.25)
	end)
	vim.keymap.set("n", "<C-->", function()
		change_scale_factor(1 / 1.25)
	end)

  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

  vim.cmd([[:FloatermNew --silent --name=sus --width=1.0 --height=1.0]])

  vim.keymap.set({'t', 'n'}, '<C-z>', '<cmd>FloatermToggle sus<cr>')
end
