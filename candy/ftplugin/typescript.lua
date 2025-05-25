require("typescript-tools").setup({
	cmd = { "typescript-language-server", "--stdio" },
	settings = {
		-- https://github.com/pmizio/typescript-tools.nvim/blob/master/lua/typescript-tools/protocol/text_document/did_open.lua#L8
		tsserver_file_preferences = {
			includeInlayParameterNameHints = "all",
			includeInlayFunctionParameterTypeHints = true,
			includeInlayEnumMemberValueHints = true,

			includeCompletionsForModuleExports = true,

			quotePreference = "auto",
		},
		tsserver_format_options = {
			allowIncompleteCompletions = false,
			allowRenameOfImportPath = false,
		},
	},
})
