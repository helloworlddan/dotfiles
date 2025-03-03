return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofumpt", "gofmt", "golines" },
        lua = { "stylua" },
        python = { "black" },
        ruby = { "rubocop" },
        sh = { "shfmt" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        proto = { "buf" },
        json = { "jq" },
        yaml = { "yq" },
        terraform = { "terraform_fmt" },
        makefile = { "checkmake" },
        ["*"] = { "codespell" },
      },
    },
  },
}
