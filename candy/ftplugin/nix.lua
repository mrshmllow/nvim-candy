-- Be more in-line with alejandra

-- Tabs / Spaces --
local tab_width = 4

vim.opt.expandtab = true

vim.opt.tabstop = tab_width
vim.opt.shiftwidth = tab_width
vim.opt.softtabstop = tab_width
vim.opt.makeprg = "statix check -o errfmt"
vim.opt.errorformat = "%f>%l:%c:%t:%n:%m"

vim.lsp.enable("nil_ls")
