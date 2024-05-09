-- Gui --
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

vim.g.neovide_refresh_rate = 240

if vim.g.neovide then
	vim.cmd.cd = "~"
end
