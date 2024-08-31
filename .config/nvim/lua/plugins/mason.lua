return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "goimports",
        "gofumpt",
        "gomodifytags",
        "impl",
        "delve",
        "golines",
        "gotests",
        "gotestsum",
      })
      vim.list_extend(opts.ensure_installed, { "ocamlformat" })
      vim.list_extend(opts.ensure_installed, { "lua-language-server" })
      vim.list_extend(opts.ensure_installed, { "hadolint" })
      vim.list_extend(opts.ensure_installed, { "json-lsp", "jsonlint", "jq" })
      vim.list_extend(opts.ensure_installed, { "markdownlint", "marksman" })
    end,
  },
}
