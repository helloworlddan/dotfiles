local plugins = {

  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gofumpt",
        "goimports",
        "goimports-reviser",
        "golines",
        "gomodifytags",
        "gopls",
        "gotests",
        "gotestsum",

        "dockerfile-language-server",

        "jsonnet-language-server",

        "ruby-lsp",
        "rubocop",

        "yaml-language-server",
        "yamlfmt",

        "json-lsp",

        "terraform-ls",
        "tflint",

        "css-lsp",

        "lua-language-server",
        "html-lsp",
        "prettier",
        "stylua"
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
     config = function()
        require "plugins.configs.lspconfig"
        require "custom.configs.lspconfig"
     end,
  },

}

return plugins
