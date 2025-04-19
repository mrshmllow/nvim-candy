-- Leader --
vim.g.mapleader = " "
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Terminal --
vim.opt.termguicolors = true

-- Undo --
vim.opt.undofile = true -- ... ouch

-- Number / Gutter / Column --
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.signcolumn = "yes"

-- Mouse --
vim.opt.mousemodel = "extend"

-- Status --
vim.opt.showmode = false
vim.opt.cmdheight = 0
vim.opt.laststatus = 3 -- Global status

vim.opt.statusline = "%{%v:lua.require'marshmallow.statusline'.statusline()%}"

-- Scrolloff --
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 8

-- Cursor --
vim.opt.cursorline = true

-- Splits --
vim.opt.splitbelow = true
vim.opt.splitright = true

-- GUI --
vim.opt.guifont = { "JetBrainsMono Nerd Font Mono", ":h14:w-1" }

-- Diagnostics --
vim.diagnostic.config({
	virtual_text = false,
	signs = false,
	update_in_insert = false,
	severity_sort = true,
})

-- Chars --
vim.opt.showbreak = "↪ "
vim.opt.list = true
vim.opt.listchars = "space:.,tab:▎·,trail:."

-- Tabs / Spaces --
local tab_width = 8

vim.opt.tabstop = tab_width
vim.opt.shiftwidth = tab_width
vim.opt.softtabstop = tab_width

-- Folds --
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false

-- Is this okay??
vim.opt.linespace = -2

-- Diagnostics --
-- I use nf-fa nerd icons
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

vim.opt.exrc = true
