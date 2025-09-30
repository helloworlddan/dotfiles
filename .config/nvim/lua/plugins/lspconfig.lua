return {
  {
    "neovim/nvim-lspconfig",
    setup = function()
      require("lspconfig").gopls.setup({
        settings = {
          gopls = {
            analyses = {
              modernize = true,
            },
          },
        },
      })
    end,
  },
}
