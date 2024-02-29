local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = true,
      ensure_installed = {
        "awk",
        "bash",
        "c",
        "cpp",
        "c_sharp",
        "css",
        "csv",
        "diff",
        "dockerfile",
        "dot",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gpg",
        "graphql",
        "haskell",
        "hcl",
        "html",
        "http",
        "java",
        "javascript",
        "jq",
        "json",
        "jsonnet",
        "lua",
        "make",
        "markdown",
        "nix",
        "passwd",
        "promql",
        "proto",
        "python",
        "regex",
        "ruby",
        "rust",
        "sql",
        "terraform",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
    },
  },
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

        "marksman",

        "sqlls",

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
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = "go",
    opts = function()
      return require "custom.configs.null-ls"
    end
  },
}
return plugins
