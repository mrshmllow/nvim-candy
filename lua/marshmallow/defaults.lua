vim.wo.signcolumn = "yes"

vim.opt.number = true
vim.opt.relativenumber = true

vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.termguicolors = true

vim.o.showmode = false

vim.o.expandtab = true
-- number of spaces used for each indentation level
vim.o.shiftwidth = 2
-- number of spaces to be inserted when the 'Tab' key is pressed
vim.o.softtabstop = 2
-- number of spaces a tab character appears as
vim.o.tabstop = 2

-- I use nf-fa nerd icons
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

vim.o.cursorline = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.laststatus = 3

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,terminal,options"
