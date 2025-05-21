local gen_loader = require("mini.snippets").gen_loader
local globals = vim.env.NIX_ABS_CONFIG .. "/snippets/global.json"

require("mini.snippets").setup({
	snippets = {
		gen_loader.from_file(globals),
		gen_loader.from_lang(),
	},
})
