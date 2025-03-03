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
        javascript = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        markdown = { "prettier" },
        proto = { "buf" },
        json = { "jq" },
        yaml = { "yq" },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        makefile = { "checkmake" },
        ["*"] = { "codespell" },
      },
    },
  },
}
