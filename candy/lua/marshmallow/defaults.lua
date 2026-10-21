-- Leader --
vim.g.mapleader = " "
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Colourscheme --
vim.g.everforest_enable_italic = true
vim.g.everforest_background = "hard"
vim.cmd.colorscheme("generated")

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
vim.opt.cmdheight = 1
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
vim.opt.guifont = { "Maple Mono NF", ":h14:w-1" }

-- Diagnostics --
vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = true,
	signs = false,
	update_in_insert = false,
	severity_sort = true,
})

-- Chars --
vim.opt.showbreak = "↪ "
vim.opt.list = true
vim.opt.listchars = { space = ".", tab = "▎·", trail = "." }

-- Tabs / Spaces --
local tab_width = 8

vim.opt.tabstop = tab_width
vim.opt.shiftwidth = tab_width
vim.opt.softtabstop = tab_width

-- Folds --
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false

-- Is this okay??
vim.opt.linespace = -2

-- Directory stuff --
vim.opt.exrc = true

-- Completion --
vim.opt.completeopt = { "menuone", "noselect", "fuzzy" }
vim.opt.wildoptions = { "fuzzy", "pum", "tagfile" }

-- Search --
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Treesitter --

-- Enable treesitter for all files.
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

-- Custom treesitter predicate to check the ft
vim.treesitter.query.add_predicate("has-filetype?", function(_, _, bufnr, pred)
	return vim.bo[bufnr].filetype == pred[2]
end, { force = true })

-- Haskell --

-- Force treesitter to read lhaskell as latex
vim.treesitter.language.register("latex", "lhaskell")
