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
      }) -- Go
      vim.list_extend(opts.ensure_installed, { "ocamlformat" }) -- OCaml
      vim.list_extend(opts.ensure_installed, { "lua-language-server" }) -- Lua
      vim.list_extend(opts.ensure_installed, { "hadolint" }) -- Docker
      vim.list_extend(opts.ensure_installed, { "black" }) -- Python
      vim.list_extend(opts.ensure_installed, { "shfmt" }) -- Bash
      vim.list_extend(opts.ensure_installed, { "prettier", "prettierd" }) -- JavaScript
      vim.list_extend(opts.ensure_installed, { "json-lsp", "jsonlint", "jq" }) -- JSON
      vim.list_extend(opts.ensure_installed, { "yq" }) -- YAML
      vim.list_extend(opts.ensure_installed, { "markdownlint", "marksman" }) -- Markdown
      vim.list_extend(opts.ensure_installed, { "superhtml" }) -- HTML
    end,
  },
}
