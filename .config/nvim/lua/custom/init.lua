local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.backup = false
opt.swapfile = false

opt.scrolloff = 10
opt.relativenumber = true
opt.wrap = false

vim.g.vscode_snippets_path = vim.fn.stdpath "config" .. "/snippets"

autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format { async = false }
  end,
})
