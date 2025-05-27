require("minuet").setup({
	virtualtext = {
		auto_trigger_ft = { "lua" },
		keymap = {
			-- accept whole completion
			accept = "<A-A>",
			-- accept one line
			accept_line = "<A-a>",
			-- accept n lines (prompts for number)
			-- e.g. "A-z 2 CR" will accept 2 lines
			accept_n_lines = "<A-z>",
			-- Cycle to prev completion item, or manually invoke completion
			prev = "<A-[>",
			-- Cycle to next completion item, or manually invoke completion
			next = "<A-]>",
			dismiss = "<A-e>",
		},
	},

	provider = "openai_compatible",
	request_timeout = 2.5,
	throttle = 1500,
	debounce = 600,
	provider_options = {
		openai_compatible = {
			api_key = "OPENROUTER_KEY",
			end_point = "https://openrouter.ai/api/v1/chat/completions",
			model = "deepseek/deepseek-chat-v3-0324",
			name = "Openrouter",
			optional = {
				max_tokens = 56,
				top_p = 0.9,
				provider = {
					-- Prioritize throughput for faster completion
					sort = "throughput",
				},
			},
		},
	},
})
