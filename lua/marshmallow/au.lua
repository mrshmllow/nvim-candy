vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.mdx",
  callback = function()
    vim.o.filetype = "markdown"
  end,
})

-- vim.cmd("autocmd BufEnter,InsertLeave,BufWritePost <buffer> lua vim.lsp.inlay_hint.refresh()")
