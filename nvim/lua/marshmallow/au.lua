vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.mdx",
  callback = function()
    vim.o.filetype = "markdown"
  end,
})

local ns = vim.api.nvim_create_namespace("LoadingIndicator")

-- vim.api.nvim_create_autocmd({ "BufReadPre" }, {
--   pattern = "*",
--   callback = function(ev)
--     local buf = ev.buf
-- 
--     vim.b.loading_ext = vim.api.nvim_buf_set_extmark(buf, ns, 0, 0, {
--       virt_text = { { "Loading...", "@comment" } },
--     })
-- 
--     local a = nil
-- 
--     vim.wait(5000, function()
--       local b = a
--       a = true
--       return b
--     end)
--   end,
-- })
-- 
-- vim.api.nvim_create_autocmd({ "BufReadPost" }, {
--   pattern = "*",
--   callback = function(ev)
--     local buf = ev.buf
-- 
--     if vim.b.loading_ext then
--       vim.api.nvim_buf_del_extmark(buf, ns, vim.b.loading_ext)
--     end
-- 
--     vim.b.loading_ext = nil
--   end,
-- })

-- vim.cmd("autocmd BufEnter,InsertLeave,BufWritePost <buffer> lua vim.lsp.inlay_hint.refresh()")
