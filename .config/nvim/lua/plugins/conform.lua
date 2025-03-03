return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofumpt", "gofmt", "golines" },
        lua = { "stylua" },
        py = { "black" },
        js = { "prettierd", "prettier" },
        ruby = { "rubocop" },
        sh = { "shfmt" },
        proto = { "buf" },
        json = { "jq" },
        yaml = { "yq" },
        html = { "superhtml" },
        tf = { "terraform_fmt" },
        markdown = { "prettierd", "prettier", "markdownlint", "markdown-toc" },
        ["terraform-vars"] = { "terraform_fmt" },
        ["markdown.mdx"] = { "prettierd", "prettier", "markdownlint", "markdown-toc" },
        ["*"] = { "codespell" },
      },
    },
  },
}
