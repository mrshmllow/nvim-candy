vim.api.nvim_create_user_command("Opacity", function()
	if vim.g.neovide_opacity ~= 1 then
		vim.g.neovide_opacity = 1
	else
		vim.g.neovide_opacity = 0.9
	end
end, {})

vim.api.nvim_create_user_command("Z", function(val)
	local obj = vim.system({ "fish", "-c", "z -e " .. val["args"] }, { text = true }):wait()

	if obj.code == 0 then
		return vim.cmd.cd(obj.stdout:sub(1, -2)) -- remove \n
	end

	vim.notify("Error: " .. obj.stderr, vim.log.levels.ERROR)
end, {
	nargs = 1,
})

local namespace = vim.api.nvim_create_namespace("marsh-mods")
local _window = nil

local get_or_create_window = function()
	-- if _window == nil then
	vim.cmd.split({ mods = { vertical = true } })
	_window = vim.api.nvim_get_current_win()
	-- end

	return _window
end

local mods_list = function()
	local window = get_or_create_window()
	local buf = vim.api.nvim_create_buf(false, true)
	-- vim.api.nvim_buf_set_name(buf, "mods://list")
	vim.api.nvim_win_set_buf(window, buf)
	vim.api.nvim_set_option_value("ft", "txt", {
		buf = buf,
	})

	local obj = vim.system({ "mods", "--list" }, {
		text = true,
	}):wait()

	if obj.stdout == nil then
		return
	end

	local lines = vim.split(obj.stdout, "\n", {
		trimempty = true,
	})

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	for key in pairs(lines) do
		vim.api.nvim_buf_set_extmark(0, namespace, key - 1, 0, {
			end_col = 7,
			hl_group = "Identifier",
		})
	end

	vim.api.nvim_set_option_value("modifiable", false, {
		buf = buf,
	})
end

local mods_prompt = function(context, arg)
	local window = get_or_create_window()

	local output = vim.fn.tempname()

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_win_set_buf(window, buf)
	vim.api.nvim_set_option_value("ft", "markdown", {
		buf = buf,
	})
	-- vim.api.nvim_set_option_value("modifiable", false, {
	-- 	buf = buf,
	-- })

	local obj = vim.system({ "mods", arg }, {
		stdin = context,
		text = true,
		detach = true,
		stdout = function(err, data)
			vim.schedule(function()
				-- if string.find(data, "\n") then
				-- 	local lines = vim.split(data, "\n")
				-- 	local last_line = vim.api.nvim_buf_line_count(buf)
				-- 	vim.api.nvim_buf_set_lines(buf, last_line, last_line, false, lines)
				-- else

				local lines = vim.split(data, "\n")

				local first = true

				for key, line in pairs(lines) do
					local length = vim.api.nvim_buf_line_count(buf)

					if not first then
						vim.api.nvim_buf_set_lines(buf, length, length, false, { "" })
						length = length + 1
					end

					local col = vim.fn.col({ length, "$" }) - 1
					-- local existing_line = vim.api.nvim_buf_get_text(buf, length - 1, 0, length - 1, -1, {})[1]
					-- local new_line = existing_line .. data
					--
					-- vim.api.nvim_buf_set_lines(buf, length - 1, length - 1, false, {
					-- 	new_line,
					-- })
					vim.api.nvim_buf_set_text(buf, length - 1, col, length - 1, col, {
						line,
					})

					first = false
				end

				-- if string.find(data, "\n") then
				-- 	vim.api.nvim_buf_set_lines(buf, length, length, false, { "" })
				-- end

				-- vim.api.nvim_win_call(window, function()
				-- 	vim.cmd("normal! G")
				-- end)
			end)
		end,
		stderr = function(err, data)
			vim.schedule(function()
				vim.notify(data, vim.log.levels.ERROR)
			end)
		end,
	})

	vim.print(obj)
end

vim.api.nvim_create_user_command("Mods", function(val)
	if val.args == "" then
		mods_list()
		return
	end

	local context = vim.api.nvim_buf_get_lines(0, val.line1, val.line2, false)

	mods_prompt(context, val.args)
end, {
	nargs = "?",
	range = "%",
	bang = true,
})
