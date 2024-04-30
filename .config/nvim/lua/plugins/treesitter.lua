return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "go",
        "gomod",
        "gowork",
        "gosum",
        "dockerfile",
        "json",
        "json5",
        "jsonc",
        "markdown",
        "markdown_inline",
      })
    end,
  },
}
