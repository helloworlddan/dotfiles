return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "goimports", "gofumpt", "gomodifytags", "impl", "delve" })
      vim.list_extend(opts.ensure_installed, { "hadolint" })
      vim.list_extend(opts.ensure_installed, { "markdownlint", "marksman" })
      vim.list_extend(opts.ensure_installed, { "solargraph" })
    end,
  },
}
