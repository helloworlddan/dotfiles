return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofumpt", "gofmt" },
        lua = { "stylua" },
        javascript = { { "prettierd", "prettier" } },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
        markdown = { { "prettierd", "prettier" }, "markdownlint", "markdown-toc" },
        ["markdown.mdx"] = { { "prettierd", "prettier" }, "markdownlint", "markdown-toc" },
        ["*"] = { "codespell" },
      },
    },
  },
}
